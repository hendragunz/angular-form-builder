class CustomRadioButtonsInput < SimpleForm::Inputs::CollectionRadioButtonsInput
  def input
    label_method, value_method = detect_collection_methods
    input_html_options[:class] = input_html_options[:class].reject{|x| x == 'form-control' }

    # @builder.send("collection_radio_buttons",
    #   attribute_name, collection, value_method, label_method,
    #   input_options, input_html_options, &collection_block_for_nested_boolean_style
    # )

    html = template.content_tag(:div, :class => "input-group") do
      @builder.collection_radio_buttons(attribute_name, collection, value_method, label_method,
        input_options, input_html_options, &collection_block_for_nested_boolean_style
      )
    end
  end
end