module AdminHelper
  def menu_list_item(url, options = { strategy: :inclusive }, &block)
    extra_class = 'active' if is_active_link?(url, options[:strategy])
    "<li class='#{extra_class}'>#{capture(&block)}</li>".html_safe
  end

  def bool_to_word(bool, type = :word)
    !bool.nil? ? I18n.t("helpers.bool_to.#{type}.if_#{bool}") : ''
  end

  def render_badge(value, type = :word)
    if value
      content_tag(:span, bool_to_word(value, type), class: 'label label-primary')
    else
      content_tag(:span, bool_to_word(value, type), class: 'label label-default')
    end
  end

  def render_sort_button(order)
    order_params = params.clone
    reversion = { 1 => :desc, -1 => :asc }
    button_classes = { -1 => :desc, 1 => :asc }
    if order_params[:order_by].try(:[], order).blank?
      rev_key = :asc
    else
      old_key = order_params[:order_by][order]
      rev_key = reversion[old_key]
      button_class = button_classes[old_key]
    end
    order_params[:order_by] = {}
    order_params[:order_by][order] = rev_key
    link_to url_for(order_params), class: 'btn btn-xs btn-white' do
      concat content_tag :i, nil, class: "fa fa-sort-#{button_class}" if button_class
      concat '&nbsp'.html_safe
      concat I18n.t("helpers.sort_by.#{order}")
    end
  end

  def render_breadcrumbs
    return unless @breadcrumbs.try(:any?)
    content_tag :ol, class: 'breadcrumb' do
      @breadcrumbs.map do |obj|
        if obj[:url]
          content_tag :li, link_to(obj[:name], obj[:url])
        else
          content_tag :li, class: 'active' do
            content_tag :strong, obj[:name]
          end
        end
      end.join.html_safe
    end
  end

  def nested_content
    content_tag 'div' do
      concat(content_tag 'span', 'span block')
      concat(tag 'br')
      concat(link_to 'root link', root_path)
      concat(tag 'br')
      concat(link_to('#') do
        concat(content_tag 'h2', 'Head \'em off')
        concat(tag 'br')
        content_tag 'div', (content_tag 'span', (concat 'dudue'))
      end)
    end
  end

  def locales_picker(type, selected, options = {})
    locales_arr = []
    locales_arr.push [I18n.t('helpers.locales.empty'), nil] if options[:include_blank]
    I18n.available_locales.map do |locale|
      locales_arr.push [I18n.t("helpers.locales.#{locale}"), locale]
    end
    content_tag :div, class: options[:class] do
      concat select_tag type, options_for_select(locales_arr, selected: selected), class: "locale-selector #{type}", data: { locale_type: type }
    end
  end

  def locale_pickers
    [locales_picker(:left, :ru, class: 'col-lg-6 col-md-12 col-sm-12 col-xs-12'), locales_picker(:right, :en,  class: 'col-lg-6 col-md-12 col-sm-12 col-xs-12')].join.html_safe
  end
end
