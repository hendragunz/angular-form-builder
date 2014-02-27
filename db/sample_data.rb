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


puts "creating forms and fields..."

30.times do |x|
	count = x + 1
  form = Form.create!(
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

  field = form.fields.create!(
      name: "field_#{count}",
      field_label: Faker::Lorem.paragraph,
      field_hint: Faker::Lorem.paragraph,
      field_type: ['mcq', 'boolean', 'single_line', 'paragraph', 'rating', 'number', 'checkbox', 'dropdown', 'section_break', 'page_break', 'name', 'address', 'date', 'email', 'time', 'phone', 'website', 'price', 'likert', 'facebook', 'twitter'].sample
  )
    field.properties = {data:"{option1: 'a', option2: 'b'}"} if field.field_type == 'mcq'
    field.properties = {data:"{format: 'words', min: '0', max: '50'}"} if field.field_type == 'single_line'
    field.properties = {data:"{format: 'character', min: '0', max: '20'}"} if field.field_type == 'paragraph'
    field.properties = {data:"{rate: '5', type: 'star'}"} if field.field_type == 'rating'
    field.properties = {data:"{true_label: 'yes', false_label: 'no'}"} if field.field_type == 'boolean'
    field.properties = {data:"{format: 'value', min:'0', max:'10'}"} if field.field_type == 'number'
    field.properties = {data:"{choice1: 'a', choice2: 'b'}"} if field.field_type == 'checkbox'
    field.properties = {data:"{select1: 'a', select2: 'b'}"} if field.field_type == 'dropdown'
    field.properties = {data:"{button_text: 'next'}"} if field.field_type == 'page_break'
    field.properties = {data:"{format: 'extended'}"} if field.field_type == 'name'
    field.properties = {data:"{format: 'character', min: '0', max: '20', currency: '$'}"} if field.field_type == 'price'
    field.properties = {data:"{row1: 'statement 1', row2:'statement 2', column1:'agree', column2: 'disagree'}"} if field.field_type == 'likert'
    field.save!
    #data: "{}" if field['field_type'] == 'address'
    #data: "{}" if field['field_type'] == 'section_break'
    #data: "{}" if field['field_type'] == 'date'
    #data: "{}" if field['field_type'] == 'email'
    #data: "{}" if field['field_type'] == 'time'
    #data: "{}" if field['field_type'] == 'phone'
    #data: "{}" if field['field_type'] == 'website'
    #data: "{}" if field['field_type'] == 'facebook'
    #data: "{}" if field['field_type'] == 'twitter'

end

