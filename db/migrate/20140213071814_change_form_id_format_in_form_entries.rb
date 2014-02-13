class ChangeFormIdFormatInFormEntries < ActiveRecord::Migration
  def change
    remove_column :form_entries, :form_id
    add_column :form_entries, :form_id, :integer
  end
end
