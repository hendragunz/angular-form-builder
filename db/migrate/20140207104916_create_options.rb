class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.integer :evaluation_form_question_id
      t.string :name

      t.timestamps
    end
  end
end
