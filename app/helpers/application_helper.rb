module ApplicationHelper

  def submit_or_cancel(form, submit_name = "", cancel_name="#{t 'cancel', default: 'Cancel'}")
    unless submit_name.blank?
      form.submit(submit_name, class: 'btn btn-primary', data: {disable_with: "#{t 'please_wait'}"}) + " #{t 'or'} " + link_to(cancel_name, 'javascript:history.go(-1);', class: 'cancel')
    else
      form.submit(class: 'btn btn-primary', data: {disable_with: "#{t 'please_wait'}"}) + " #{t 'or'} " + link_to(cancel_name, 'javascript:history.go(-1);', class: 'cancel')
    end
  end

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

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    options = {sort: column, direction: direction}
    options.merge!(params.slice(:search, :day))
    link_to title, options, {class: css_class}
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def get_options_count(form, field)
    entries = form.entries
    results = {}
    data_table = GoogleVisualr::DataTable.new
    entries.each do |entry|
      answer = entry.answers
      field.field_options.each do |option|
        key = field.id.to_s+'_'+option.id.to_s
        results[option.name] = 0 if results[option.name].nil?
        results[option.name] = results[option.name] + 1 if answer[key] == option.name
      end
    end
    #results.map{ |key , value| results[key] = ((value.to_f/entries.count.to_f)*100).to_s + "%"}
    #results
    data_table.add_rows(results.count)
    index = 0
    data_table.new_column('string', 'Options')
    data_table.new_column('number', 'Count')
    results.map do |key, value|
      data_table.set_cell(index, 0, key)
      data_table.set_cell(index, 1, value)
      index = index + 1
    end
    opts = { width: 400, height: 240, title: field.name+' '+'Results', hAxis: { title: 'Options', titleTextStyle: {color: 'red'}} }
    @chart = GoogleVisualr::Interactive::ColumnChart.new(data_table, opts)
  end

  def get_scale_average(form, field)
    entries = form.entries
    results = {}
    key = field.id.to_s
    results[key] = 0
    entries.each do |entry|
      answer = entry.answers
      results[key] = results[key] + answer[key].to_i
    end
    (results[key].to_f/entries.count.to_f).to_s
  end

  def get_bool_count(form, field)
    entries = form.entries
    results = {}
    key = field.id.to_s
    results[field.attributes[:true_label]] = 0
    results[field.attributes[:false_label]] = 0
    data_table = GoogleVisualr::DataTable.new
    entries.each do |entry|
      answer = entry.answers
      if answer[key] == 'true'
        results[field.attributes[:true_label]] = results[field.attributes[:true_label]] + 1
      else
        results[field.attributes[:false_label]] = results[field.attributes[:false_label]] + 1
      end
    end
    #results
    data_table.add_rows(results.count)
    index = 0
    data_table.new_column('string', 'Labels')
    data_table.new_column('number', 'Count')
    results.map do |key, value|
      data_table.set_cell(index, 0, key)
      data_table.set_cell(index, 1, value)
      index = index + 1
    end
    opts = { width: 400, height: 240, title: field.name+' '+'Results', hAxis: { title: 'Options', titleTextStyle: {color: 'red'} } }
    @chart = GoogleVisualr::Interactive::ColumnChart.new(data_table, opts)
  end

  def get_entries(form, field)
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
