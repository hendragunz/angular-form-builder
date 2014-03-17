class AddImageIntoFormFields < ActiveRecord::Migration
  def up
    add_attachment :field_options, :picture
  end

  def down
    remove_attachment :field_options, :picture
  end
end
