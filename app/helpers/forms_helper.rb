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

end