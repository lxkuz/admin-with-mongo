class ChartAttendance
  constructor: (el)->
    @el = $ el 
    @chart = $ ".chart canvas", @el
    @type =  $(".chart", @el).data("type")
    @stats = $ ".chart", @el
    @totals = $ ".totals", @el
    @getData()

  getData: =>
    $.ajax
      url: "/admin/metrics/period"
      data: 
        type: @type
      success: @drawChart
  
  drawChart: (data) =>
    preparedData = @prepareData(data)
    ctx = @chart.get(0).getContext("2d")
    myNewChart = new Chart(ctx).Line(preparedData, @lineOptions)
    legend = myNewChart.generateLegend()
    @stats.prepend(legend)
    @fillTotals(data.totals, @type)

  prepareData: (data) =>
    if data.totals.avg_visits
      data.totals.avg_visits = Math.round(data.totals.avg_visits)
    preparedData = @["#{@type}Chart"](data)

  monthChart: (data) =>
    labels = []
    values = []
    for k, v of data.data.reverse()
      labels.push @formatDate(v.date)
      values.push v.visitors
    lineData = 
      labels: labels
      datasets: [
        {
          label: "Example dataset"
          fillColor: "rgba(26,179,148,0.5)"
          strokeColor: "rgba(26,179,148,0.7)"
          pointColor: "rgba(26,179,148,1)"
          pointStrokeColor: "#fff"
          pointHighlightFill: "#fff"
          pointHighlightStroke: "rgba(26,179,148,1)"
          data: values
        }
      ]

  weekChart: (data) =>
    labels = []
    values = []
    for k, v of data.data.reverse()
      labels.push @formatDate(v.date)
      values.push v.visitors
    lineData = 
      labels: labels
      datasets: [
        {
          label: "Example dataset"
          fillColor: "rgba(26,179,148,0.5)"
          strokeColor: "rgba(26,179,148,0.7)"
          pointColor: "rgba(26,179,148,1)"
          pointStrokeColor: "#fff"
          pointHighlightFill: "#fff"
          pointHighlightStroke: "rgba(26,179,148,1)"
          data: values
        }
      ]  
        
  hourlyChart: (data) => 
    labels = []
    values = []
    for k, v of data.data
      labels.push v.hours
      values.push Math.round(v.avg_visits)
    lineData = 
      labels: labels
      datasets: [
        {
          label: "Example dataset"
          fillColor: "rgba(26,179,148,0.5)"
          strokeColor: "rgba(26,179,148,0.7)"
          pointColor: "rgba(26,179,148,1)"
          pointStrokeColor: "#fff"
          pointHighlightFill: "#fff"
          pointHighlightStroke: "rgba(26,179,148,1)"
          data: values
        }
      ]

  lineOptions:
    scaleShowGridLines: true
    scaleShowLabels: true
    scaleGridLineColor: "rgba(0,0,0,.05)"
    scaleGridLineWidth: 1
    bezierCurve: true
    bezierCurveTension: 0.4
    pointDot: true
    pointDotRadius: 4
    pointDotStrokeWidth: 1
    pointHitDetectionRadius: 20
    datasetStroke: true
    datasetStrokeWidth: 2
    datasetFill: true
    responsive: true 
    skipXLabels: 10
    maintainAspectRatio: false
    legendTemplate : "<p><span></span> Визиты</p>"

  # it's awful, but it works
  formatDate: (string) =>
    y = string.substring(0, 4)
    m = string.substring(4, 6)
    d = string.substring(6, 8)
    return new Date(y, m - 1, d).toLocaleDateString("ru-RU")

  fillTotals: (data, type) =>
    wishList = ['avg_visits', 'new_visitors', 'page_views', 'visitors', 'visits']
    for k, v of data
      if _(wishList).include(k)
        @totals.append($("<p>#{t('admin.chart.' + k)}: <strong>#{v}</strong></p>"))

window.addComponent ChartAttendance, className: 'chart-attendance'
