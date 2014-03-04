class ChangeFormFieldsRequiredToFalse < ActiveRecord::Migration
  def up
    change_column :form_fields, :required, :boolean, default: false
  end

  def down
    change_column :form_fields, :required, :boolean, default: true
  end
end
