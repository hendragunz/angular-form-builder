class CreateFormFields < ActiveRecord::Migration
  def change
    create_table :form_fields do |t|
      t.string  :name
      t.text    :en_label
      t.text    :fr_label
      t.text    :en_hint
      t.text    :fr_hint
      t.string  :field_type
      t.hstore  :properties
      t.boolean :required, default: true
      t.integer :position, default: 0
      t.integer :form_id

      t.timestamps
    end
  end
end
