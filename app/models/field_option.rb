# == Schema Information
#
# Table name: field_options
#
#  id                   :integer          not null, primary key
#  form_field_id        :integer
#  name                 :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

class FieldOption < ActiveRecord::Base

  # ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  belongs_to :form_field

  before_destroy :check_for_entries

  # add persisted => true
  # when call method to_json
  #
  def as_json(options = {})
    # this example ignores user's options
    super(options).merge(persisted: persisted?)
  end

  private

    def check_for_entries
      @entries = FormEntry.find_by_form_id(self.form_field.form_id)
      if @entries
        @entries.answers = @entries.answers.reject{ |k| k.split('_').second == self.id.to_s }
        @entries.save
      end
    end

end
