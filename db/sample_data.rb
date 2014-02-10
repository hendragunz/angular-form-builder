puts "SAMPLE DATA"

puts "creating forms..."

10.times do |x|
	count = x + 1
	Form.create!(
		name: "#{('a'..'z').to_a.sample.capitalize} score #{count}",
		active: [true, false].sample,
		scope: "",
		introduction: Faker::Lorem.paragraphs(2).join(' '),
		conclusion: Faker::Lorem.paragraphs(2).join(' '),
		max_entries_allowed: [nil, 100].sample,
	  end_date: Date.today + 3.months
	)
end

puts "creating form fields..."

60.times do |x|
	count = x + 1
	field = FormField.create!(
		name: "field_#{count}",
		en_label: Faker::Lorem.paragraph,
    fr_label: Faker::Lorem.paragraph,
		en_hint: Faker::Lorem.paragraph,
		fr_hint: Faker::Lorem.paragraph,
		field_type: ['mcq', 'boolean', 'single_line', 'paragraph', 'rating'].sample,
		scale: (1..5).to_a.sample,
		true_label: "Yes",
    false_label: "No",
		form_id: (2..10).to_a.sample
	)

  field.field_options.create!([
    { name: "Option 1" },
    { name: "Option 2" },
    { name: "Option 3" },
    { name: "Option 4" }
  ])
end