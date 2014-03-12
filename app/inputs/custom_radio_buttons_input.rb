class CustomRadioButtonsInput < SimpleForm::Inputs::CollectionRadioButtonsInput
  def input
    label_method, value_method = detect_collection_methods
    input_html_options[:class] = input_html_options[:class].reject{|x| x == 'form-control' }

    buffer  = ""
    buffer2 = ""

    html = template.content_tag(:div, class: "input-group") do
      collection.each do |col|
        buffer += template.content_tag(:div, class: 'radio') do
          @builder.collection_radio_buttons(attribute_name, [col], value_method, label_method,input_options, input_html_options, &collection_block_for_nested_boolean_style)
        end
      end

      buffer.html_safe
    end
  end

  private

    def item_wrapper_class
      # "radio-inline"
    end

end