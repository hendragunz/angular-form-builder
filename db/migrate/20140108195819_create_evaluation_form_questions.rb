class CreateEvaluationFormQuestions < ActiveRecord::Migration
  def change
    create_table :evaluation_form_questions do |t|
      t.text    :en_name
      t.text    :fr_name
      t.text    :en_hint
      t.text    :fr_hint
      t.string  :question_type
      t.integer :scale
      t.integer :position, default: 0
      t.integer :evaluation_form_id

      t.timestamps
    end
  end
end
