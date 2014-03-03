class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.string   :name
      t.string   :slug, null: false, uniq: true
      t.text     :introduction
      t.text     :confirmation_message
      t.integer  :max_entries_allowed
      t.boolean  :unique_ip_only, default: false
      t.boolean  :send_email_confirmation, default: false
      t.boolean  :show_questions_one_by_one, default: false
      t.datetime :start_date
      t.datetime :end_date
      t.string   :persons_to_notify
      t.integer  :entries_count, default: 0
      t.integer  :user_id

      t.timestamps
    end

    add_index :forms, :slug
  end
end
