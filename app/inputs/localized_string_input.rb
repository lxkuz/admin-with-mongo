class LocalizedStringInput < SimpleForm::Inputs::Base
  enable :placeholder, :maxlength, :pattern
  include Haml::Helpers

  def input(wrapper_options = nil)
    unless string?
      input_html_classes.unshift('string')
      input_html_options[:type] ||= input_type if html5?
    end
    object = @builder.object
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    translated_attribute_name = "#{attribute_name}_translations"
    init_haml_helpers
    capture_haml do
      haml_tag :div, class: 'row localized-row' do
        @builder.fields_for translated_attribute_name, translated_attribute_name do |fo|
          I18n.available_locales.map do |locale|
            value = object.send(translated_attribute_name)[locale]
            merged_input_options[:value] = value
            haml_tag :div, class: 'col-lg-6 col-md-12 col-sm-12 col-xs-12 localized-field', data: { locale: locale } do
              a = build_localized_element(fo, locale, merged_input_options).gsub("\n", '')
              haml_concat a
            end
          end
        end
      end
    end
  end

  protected

  def build_localized_element(form, locale, merged_input_options)
    form.text_field locale, merged_input_options
  end

  private

  def string?
    input_type == :string
  end
end
