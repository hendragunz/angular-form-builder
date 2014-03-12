class InlineCheckBoxesInput < SimpleForm::Inputs::CollectionRadioButtonsInput
  def input
    label_method, value_method = detect_collection_methods
    input_html_options[:class] = input_html_options[:class].reject{|x| x == 'form-control' }

    html = template.content_tag(:div, class: "input-group") do
      @builder.collection_check_boxes(attribute_name, collection, value_method, label_method,
        input_options, input_html_options, &collection_block_for_nested_boolean_style
      )
    end
  end

  protected

    # Checkbox components do not use the required html tag.
    # More info: https://github.com/plataformatec/simple_form/issues/340#issuecomment-2871956
    def has_required?
      false
    end

    def build_nested_boolean_style_item_tag(collection_builder)
      collection_builder.check_box + collection_builder.text
    end

    def item_wrapper_class
      #"checkbox"
    end
end