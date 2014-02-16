class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :owner_id
      t.integer :plan_id
      t.integer :trial_days_left, default: 14

      t.timestamps
    end
  end
end
