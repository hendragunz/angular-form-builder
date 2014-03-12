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

  # CAPABILITIES
  # ------------------------------------------------------------------------------------------------------
  has_attached_file :picture, :styles => {
    :thumb  => "100x100>",
    :medium => "100x100>"
  }, :default_url => "/field_options/:style_missing.png"


  # ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  belongs_to :form_field

  # CALLBACKS
  # ------------------------------------------------------------------------------------------------------
  before_destroy :check_for_entries

  # VALIDATIONS
  # ------------------------------------------------------------------------------------------------------
  validates_attachment_content_type :picture,
                                    :allow_blank => true,
                                    :content_type => /\Aimage\/.*\Z/

  # add persisted => true
  # when call method to_json
  #
  def as_json(options = {})
    # this example ignores user's options
    super(options).merge(persisted: persisted?, picture_thumb_url: picture.url(:thumb), picture_medium_url: picture.url(:medium))
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
