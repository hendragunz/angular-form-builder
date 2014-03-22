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
  has_attached_file :picture, styles: {
    thumb:  "150x150#",
    medium: "250x250",
  }, default_url: "/assets/holder.js/170x180"


  # ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  belongs_to :form_field


  # CALLBACKS
  # ------------------------------------------------------------------------------------------------------
  before_destroy :check_for_entries


  # VALIDATIONS
  # ------------------------------------------------------------------------------------------------------
  validates_attachment_content_type :picture,
                                    less_than: 5.megabytes,
                                    allow_blank: true,
                                    content_type: /\Aimage\/.*\Z/


  # add persisted => true
  # when call method to_json
  #
  def as_json(options = {})
    # this example ignores user's options
    super(options).merge(persisted: persisted?, picture_thumb_url: picture.url(:thumb), picture_medium_url: picture.url(:medium))
  end

  private

    def check_for_entries
      # form_field.form.entries.each do |entry|
      #   entry.answers = entryentries.answers.reject{ |k| k.split('_').second == self.id.to_s }
      #   entry.save
      # end
    end

end
