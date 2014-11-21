class DateTimeInput < SimpleForm::Inputs::DateTimeInput
  def input(wrapper_options = nil)
    value = object.send(attribute_name) || Date.today

    input_html_options[:class].push 'date-input'
    input_html_options[:value] = value.strftime('%d.%m.%Y')

    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    @builder.text_field(attribute_name, merged_input_options)
  end
end
