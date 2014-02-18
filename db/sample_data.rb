puts "SAMPLE DATA"

puts "creating users..."

3.times do |x|
	count = x + 1
  user = User.create!(
           email: "user#{count}@email.com",
           first_name: Faker::Name.first_name,
           last_name: Faker::Name.last_name,
           password: "123123"
          )
  account = Account.create!(owner_id: user.id)
  user.account_id = account.id
  user.save!
  #sample_data_for(user)
end


puts "creating forms..."

10.times do |x|
	count = x + 1
	Form.create!(
		name: "#{('a'..'z').to_a.sample.capitalize} score #{count}",
		send_email_confirmation: [true, false].sample,
		unique_ip_only: [true, false].sample,
		introduction: Faker::Lorem.paragraphs(2).join(' '),
		confirmation_message: Faker::Lorem.paragraphs(2).join(' '),
		max_entries_allowed: [nil, 100].sample,
	  start_date: [nil, Date.today + 1.months].sample,
	  end_date: [nil, Date.today + 3.months].sample,
	  show_questions_one_by_one: [true, false].sample,
	  send_email_confirmation: [true, false].sample,
	  user_id: User.all.map(&:id).sample
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
