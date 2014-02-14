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

  def get_options_count(form,field)
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
    opts = { :width => 400, :height => 240, :title => field.name+' '+'Results', :hAxis => { :title => 'Options', :titleTextStyle => {:color => 'red'}} }
    @chart = GoogleVisualr::Interactive::ColumnChart.new(data_table, opts)
  end

  def get_scale_average(form,field)
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

  def get_bool_count(form,field)
    entries = form.entries
    results = {}
    key = field.id.to_s
    results[field.true_label] = 0
    results[field.false_label] = 0
    data_table = GoogleVisualr::DataTable.new
    entries.each do |entry|
      answer = entry.answers
      if answer[key] == 'true'
        results[field.true_label] = results[field.true_label] + 1
      else
        results[field.false_label] = results[field.false_label] + 1
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
    opts = { :width => 400, :height => 240, :title => field.name+' '+'Results', :hAxis => { :title => 'Options', :titleTextStyle => {:color => 'red'}} }
    @chart = GoogleVisualr::Interactive::ColumnChart.new(data_table, opts)
  end
  
end
