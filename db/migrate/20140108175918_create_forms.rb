class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.string   :name
      t.boolean  :active, default: true
      t.text     :scope
      t.text     :introduction
      t.text     :confirmation_message
      t.integer  :max_entries_allowed
      t.datetime :end_date
      t.integer  :entries_count, default: 0
      t.integer  :user_id

      t.timestamps
    end
  end
end
