class WebsiteInput < SimpleForm::Inputs::StringInput
  def input
    input_html = input_html_options.dup
    input_html[:as] ||= :url

    html = template.content_tag(:div, :class => "input-group") do
      template.content_tag(:span, :class => "input-group-addon") do
        "http://"
      end + @builder.input_field(attribute_name, input_html)
    end
  end
end