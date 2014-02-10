class CreateFieldOptions < ActiveRecord::Migration
  def change
    create_table :field_options do |t|
      t.integer :form_field_id
      t.string  :name

      t.timestamps
    end
  end
end
