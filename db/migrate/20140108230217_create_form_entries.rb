class CreateFormEntries < ActiveRecord::Migration
  def change
    create_table :form_entries do |t|
      t.integer  :form_id
      t.hstore   :answers
      t.text     :user_info

      t.timestamps
    end
  end
end
