class CreateFormFields < ActiveRecord::Migration
  def change
    create_table :form_fields do |t|
      t.string  :name
      t.text    :field_label
      t.text    :field_hint
      t.string  :field_type
      t.hstore  :properties
      t.integer :scale
      t.string  :options
      t.string  :true_label
      t.string  :false_label
      t.boolean :required, default: true
      t.integer :position, default: 0
      t.integer :form_id

      t.timestamps
    end
  end
end
