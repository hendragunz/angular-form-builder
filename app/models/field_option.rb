class FieldOption < ActiveRecord::Base

  # ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  belongs_to :form_field #, class_name: "FormField" #, foreign_key: "form_field_id"

  before_destroy :check_for_entries

  private

  def check_for_entries
    @entries = FormEntry.find_by_form_id(self.form_field.form_id)
    if @entries
      @entries.answers = @entries.answers.reject{ |k| k.split('_').second == self.id.to_s }
      @entries.save
    end
  end

end
