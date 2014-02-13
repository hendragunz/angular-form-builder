module ApplicationHelper

	def page_title(title, &block)
    page_actions = block_given? ? capture(&block) : ''
    content_tag(:div, class: "page-title") do
      content_tag(:h1, (title + page_actions).html_safe)
    end
  end

  def page_section(title, &block)
    page_actions = block_given? ? capture(&block) : ''
    content_tag(:div, class: "page-section") do
      content_tag(:h3, (title + page_actions).html_safe)
    end
  end

  def icon_tag(icon)
    "<i class='glyphicon glyphicon-#{icon}'></i>".html_safe
  end

  def get_entries(form,field)
    entries = form.entries
    results = {}
    entries.each do |entry|
      answer = entry.answers
      field.field_options.each do |option|
        key = field.id.to_s+'_'+option.id.to_s
        results[option.name] = 0 if results[option.name].nil?
        results[option.name] = results[option.name] + 1 if answer[key] == option.name
      end
    end
    results.map{ |key , value| results[key] = ((value.to_f/entries.count.to_f)*100).to_s + "%"}
    results
  end
  
end
