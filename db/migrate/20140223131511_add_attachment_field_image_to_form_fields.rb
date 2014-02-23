class AddAttachmentFieldImageToFormFields < ActiveRecord::Migration
  def self.up
    change_table :form_fields do |t|
      t.attachment :field_image
    end
  end

  def self.down
    drop_attached_file :form_fields, :field_image
  end
end
