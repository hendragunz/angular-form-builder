class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.string  :access_token
      t.string  :name
      t.integer :user_id

      t.timestamps
    end

    add_index :api_keys, [:access_token, :user_id]
  end
end
