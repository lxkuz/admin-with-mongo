class ImageInput < SimpleForm::Inputs::FileInput
  def input(wrapper_options = nil)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    out = ''
    if object.send(attribute_name)
      out << template.link_to(object.send(attribute_name).url, class: 'img-thumbnail') do
        template.image_tag(object.send(attribute_name).thumb('110x90#').url)
      end
    end
    out << template.content_tag(:div)
    out << @builder.file_field(attribute_name, merged_input_options)
    out << @builder.hidden_field("retained_#{attribute_name}", merged_input_options)
    if object.send(attribute_name)
      out << @builder.check_box("remove_#{attribute_name}", class: 'delete-checkbox')
      out << template.content_tag(:span, t('helpers.delete'), class: 'delete-checkbox-label')
    end
    out
  end
end
