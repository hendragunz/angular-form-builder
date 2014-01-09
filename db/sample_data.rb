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
		en_name: Faker::Lorem.paragraph,
    fr_name: Faker::Lorem.paragraph,
		en_hint: Faker::Lorem.paragraph,
		fr_hint: Faker::Lorem.paragraph,
		question_type: ['mcq', 'boolean', 'long_text', 'rating'].sample,
		scale: (1..5).to_a.sample,
		evaluation_form_id: EvaluationForm.all.pluck(:id)
	)
end