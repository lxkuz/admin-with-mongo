class LocalizedImperaviInput < LocalizedTextInput
  def input
    input_html_options[:class].push 'imperavi-input'
    super
  end
end
