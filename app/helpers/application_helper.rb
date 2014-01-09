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
  
end
