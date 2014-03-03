# == Schema Information
#
# Table name: form_fields
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  field_label   :text
#  field_hint    :text
#  field_type :string(255)
#  properties :hstore
#  required   :boolean          default(TRUE)
#  position   :integer          default(0)
#  form_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class FormField < ActiveRecord::Base

	# CAPABILITIES
  # ------------------------------------------------------------------------------------------------------
  # has_attached_file :field_image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"

  # ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  belongs_to  :form
  has_many    :field_options, dependent: :destroy

  # ACCEPT NESTED ATTRIBUTES
  # ------------------------------------------------------------------------------------------------------
  accepts_nested_attributes_for :field_options, reject_if: :all_blank, allow_destroy: true


  # ATTRIBUTES
  # ------------------------------------------------------------------------------------------------------
  # hstore
  # store_accessor :properties, :currency, :scale_rate, :scale_type, :true_label, :false_label, :options, :likert_rows, :likert_columns
  store_accessor :properties, :data


  # SCOPES
  # ------------------------------------------------------------------------------------------------------
  default_scope { order('position') }


  # VALIDATIONS
  # ------------------------------------------------------------------------------------------------------
  validates :name,        presence: true,
                          uniqueness: { scope: :form_id, case_sensitive: false }
  validates :field_label, presence: true
  # validates_attachment_content_type :field_image, content_type: %w(image/jpeg image/jpg image/png)

  # validates :scale, presence: true, numericality: { greater_than: 0 }, if: Proc.new { |question| question.rating? }
  # validates :options, presence: true, length: { maximum: 255 }, if: Proc.new { |question| question.mcq? }
  # validates :true_label, presence: true, length: { maximum: 255 }, if: Proc.new { |question| question.boolean? }
  # validates :false_label, presence: true, length: { maximum: 255 }, if: Proc.new { |question| question.boolean? }


  # CALLBACKS
  # ------------------------------------------------------------------------------------------------------
  before_save :format_attributes
  before_destroy :check_for_entries


	# INSTANCE METHODS
  # ------------------------------------------------------------------------------------------------------

  def can_be_deleted?
  	true
  end

  def as_json(options = {})
    # this example ignores the user's options
    super(options).merge(persisted: persisted?, field_options: field_options.map{|x| x.as_json})
  end

  private

    def format_attributes
    	self.name = name.underscore
    end

    def check_for_entries
      @entries = FormEntry.find_by_form_id(self.form_id)
      if @entries
        @entries.answers = @entries.answers.reject{ |k| k.split('_').first == self.id.to_s }
        @entries.save
      end
    end

end
