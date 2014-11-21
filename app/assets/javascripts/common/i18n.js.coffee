class window.I18n
  translate: =>
    args = arguments
    path_with_points = args[0]

    path = "['#{path_with_points.split(".").join("']['")}']"
    try
      res = eval "this.data#{path}"
      throw "undefined" if res is undefined
      if res instanceof Object
        pluralizeCount = _(arguments).last()
        pluralizeKey = @getPluralizeKey pluralizeCount
        res = res[pluralizeKey]
      params = res.match /%{.+?}/g
      if params
        for param, index in params
          res = res.replace param, args[index + 1]
      res
    catch err
      "translation missing #{@currentLocale}.#{path_with_points}"

  getPluralizeKey: (n) =>
    switch @currentLocale
      when "ru" then @getPluralizeKeyRu n
      when "en" then @getPluralizeKeyEn n

  getPluralizeKeyEn: (n)=>
    if n is 1
      "one"
    else
      "other"

  getPluralizeKeyRu: (n) =>
    if (n % 10 == 1) && (n % 100 != 11)
      "one"
    else
      if _([2, 3, 4]).include(n % 10) && (!_([12, 13, 14]).include(n % 100))
        "few"
      else
        if (n % 10 == 0) || (_([5, 6, 7, 8, 9]).include(n % 10)) || (_([11, 12, 13, 14]).include(n % 100))
          "many"
        else
          "other"

window.defaultData =
  ru:
    messages:
      loading: "Загрузка"
  en:
    messages:
      loading: "Loading"

window.i18n = new I18n
window.t = i18n.translate

locale = window.i18n.currentLocale = "ru"#gon.currentLocale
window.i18n.data = window.defaultData[locale]

$.getJSON "/locales", (data) ->
  window.i18n.data = data
