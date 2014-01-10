class CreateEvaluationFormQuestions < ActiveRecord::Migration
  def change
    create_table :evaluation_form_questions do |t|
      t.string  :name
      t.text    :en_label
      t.text    :fr_label
      t.text    :en_hint
      t.text    :fr_hint
      t.string  :question_type
      t.hstore  :properties
      #t.integer :scale
      #t.string  :options
      #t.string  :true_label
      #t.string  :false_label
      t.boolean :required, default: true
      t.integer :position, default: 0
      t.integer :evaluation_form_id

      t.timestamps
    end
  end
end
