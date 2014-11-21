class LocalizedTextInput < LocalizedStringInput
  protected

  def build_localized_element(form, locale, merged_input_options)
    form.text_area locale, merged_input_options
  end
end
