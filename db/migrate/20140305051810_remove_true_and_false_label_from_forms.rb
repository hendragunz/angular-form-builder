class RemoveTrueAndFalseLabelFromForms < ActiveRecord::Migration
  def up
    remove_column :form_fields, :true_label
    remove_column :form_fields, :false_label
  end

  def down
    add_column :form_fields, :true_label, :string
    add_column :form_fields, :false_label, :string
  end
end
