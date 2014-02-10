class FieldOption < ActiveRecord::Base

  # ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  belongs_to :form_field #, class_name: "FormField" #, foreign_key: "form_field_id"

end
