class CreateEvaluationForms < ActiveRecord::Migration
  def change
    create_table :evaluation_forms do |t|
      t.string  :name
      t.boolean :active, default: true
      t.text    :scope
      t.text    :introduction
      t.text    :conclusion
      t.integer :creator_id 

      t.timestamps
    end
  end
end
