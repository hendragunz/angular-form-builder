module FormsHelper

  # Return collection of rating field type options
  #
  def build_rating_options(form_field)
    max_rating = form_field.properties['max_rating'].to_i
    symbol     = form_field.properties['symbol']

    Array.new.tap do |arr|
      (1..max_rating).to_a.each do |num|
        arr <<  if (symbol == 'number')
                  [num.to_s, num]
                else
                  [(content_tag(:i, '', class: "fa #{symbol}") * num).html_safe, num]
                end
      end
    end
  end


  # return class for group's column base on how much column is it
  # Min Columns  1
  # Max Columns  5
  #
  def build_class_question_group_column(form_field)
    return nil if form_field.field_type != 'question_group'
    return nil if form_field.properties.blank?

    case form_field.properties['groups'].length
    when 1
      "col-xs-10"
    when 2
      "col-xs-5"
    when 3
      "col-xs-3"
    when 4
      "col-xs-2"
    when 5
      "col-xs-2"
    else
      nil
    end
  end

end