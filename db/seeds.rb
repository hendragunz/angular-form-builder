puts "SEEDS DATA"

puts "creating Oscore form."

oscore = Form.create!(
		name: "Oscore",
		active: true,
		scope: "",
		introduction: "Scale:\n
1. 'I had to do' - i.e. requires complete hands on guidance, did not do, or not given the opportunity to do\n
2. 'I had to talk them through' - i.e. able to perform tasks but requires constant direction\n
3. 'I had to prompt them from time to time' - i.e. demontstrates some independence, but requires intermittent direction\n
4. 'I needed to be in the room, just in case' - i.e. independence, but unaware of risks and still requires supervision for safe practice\n
5. 'I did not need to be there' - i.e. complete independence, understands risks and performs safely, practice ready")


oscore.fields.create!(
  name: "Pre-procedural Plan",
  en_label: "Pre-procedural Plan",
  en_hint: "Gathers/assesses required information to reach diagnosis and determine correct procedure required",
  field_type: "rating",
  scale: 5,
  position: 0
)

oscore.fields.create!(
  name: "Case Preparation",
  en_label: "Case Preparation",
  en_hint: "Patient correclty prepared and positioned, understands approach and required instruments, prepared to deal with potential complications",
  field_type: "rating",
  scale: 5,
  position: 1
)

oscore.fields.create!(
  name: "Knowledge of Specific Procedural Steps",
  en_label: "Knowledge of Specific Procedural Steps",
  en_hint: "Understands steps of procedure, potential risks and means to avoid / overcome them",
  field_type: "rating",
  scale: 5,
  position: 2
)

oscore.fields.create!(
  name: "Technical Performance",
  en_label: "Technical Performance",
  en_hint: "Efficiently performs steps avoiding pitfalls and respecting soft tissues",
  field_type: "rating",
  scale: 5,
  position: 3
)

oscore.fields.create!(
  name: "Visuospatial skills",
  en_label: "Visuospatial skills",
  en_hint: "3D spatial orientation and able to position instruments / hardware where intended",
  field_type: "rating",
  scale: 5,
  position: 4
)

oscore.fields.create!(
  name: "Post procedural plan",
  en_label: "Post procedural plan",
  en_hint: "Appropriate complete post-procedure plan",
  field_type: "rating",
  scale: 5,
  position: 5
)

oscore.fields.create!(
  name: "Efficacy and Flow",
  en_label: "Efficacy and Flow",
  en_hint: "Obvious planned course of procedure with economy of movement and flow",
  field_type: "rating",
  scale: 5,
  position: 6
)

oscore.fields.create!(
  name: "Communication",
  en_label: "Communication",
  en_hint: "Professional and effective communication / utilization of staff",
  field_type: "rating",
  scale: 5,
  position: 7
)

oscore.fields.create!(
  name: "Is independent",
  en_label: "Resident is able to safely perform this procedure independently",
  field_type: "boolean",
  true_label: "Yes",
  false_label: "No",
  position: 8
)

oscore.fields.create!(
  name: "Positive aspect",
  en_label: "Give at least 1 specific aspect of procedure done well",
  field_type: "paragraph",
  position: 9
)

oscore.fields.create!(
  name: "Suggestion",
  en_label: "Give at least 1 specific suggestion for improvement",
  field_type: "paragraph",
  position: 10
)
