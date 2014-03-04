class FacebookInput < SimpleForm::Inputs::StringInput
  def input
    input_html = input_html_options.dup
    input_html[:as] ||= :string

    html = template.content_tag(:div, :class => "input-group") do
      template.content_tag(:span, :class => "input-group-addon") do
        template.content_tag(:i, '', :class => "fa fa-facebook")
      end + @builder.input_field(attribute_name, input_html)
    end
  end
end