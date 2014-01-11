puts "SAMPLE DATA"

puts "creating evaluation forms..."

10.times do |x|
	count = x + 1
	EvaluationForm.create!(
		name: "#{('a'..'z').to_a.sample.capitalize} score #{count}",
		active: [true, false].sample,
		scope: "",
		introduction: Faker::Lorem.paragraphs(2).join(' '),
		conclusion: Faker::Lorem.paragraphs(2).join(' ')
	)
end

puts "creating evaluation form questions..."

60.times do |x|
	count = x + 1
	EvaluationFormQuestion.create!(
		name: "question_#{count}",
		en_label: Faker::Lorem.paragraph,
    fr_label: Faker::Lorem.paragraph,
		en_hint: Faker::Lorem.paragraph,
		fr_hint: Faker::Lorem.paragraph,
		question_type: ['mcq', 'boolean', 'single_line', 'paragraph', 'rating'].sample,
		scale: (1..5).to_a.sample,
		options: "Option 1, Option 2, Option 3, Option 4",
		true_label: "Yes",
    false_label: "No",
		evaluation_form_id: (2..10).to_a.sample
	)
end