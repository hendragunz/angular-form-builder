class AddFieldsToFormField < ActiveRecord::Migration
  def change
    add_column :form_fields, :size, :string
    add_column :form_fields, :page, :integer, :null => false, :default => 1
    add_column :form_fields, :show_to, :string
  end
end
