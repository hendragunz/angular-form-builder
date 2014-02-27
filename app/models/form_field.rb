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

  # CONSTANTS
  # ------------------------------------------------------------------------------------------------------
  module FieldType
    MCQ           = 'mcq'
    SINGLE_LINE   = 'single_line'
    PARAGRAPH     = 'paragraph'
    RATING        = 'rating'
    BOOLEAN       = 'boolean'
    NUMBER        = 'number'
    CHECKBOX      = 'checkbox'
    DROPDOWN      = 'dropdown'
    NAME          = 'name'
    ADDRESS       = 'address'
    DATE          = 'date'
    EMAIL         = 'email'
    TIME          = 'time'
    PHONE         = 'phone'
    WEBSITE       = 'website'
    PRICE         = 'price'
    LIKERT        = 'likert'
    FACEBOOK      = 'facebook'
    TWITTER       = 'twitter'

    def self.options
      [ RATING, MCQ, SINGLE_LINE, PARAGRAPH, BOOLEAN, NUMBER, CHECKBOX, DROPDOWN, NAME, ADDRESS,
        DATE, EMAIL, TIME, PHONE, WEBSITE, PRICE, LIKERT, FACEBOOK, TWITTER]
    end

    def self.options_with_label
      [ ['MCQ', MCQ], ['Single Line Text', SINGLE_LINE], ['Paragraph Text', PARAGRAPH], ['Rating', RATING], ['Yes/No', BOOLEAN],
      [ 'Number', NUMBER],['Checkbox', CHECKBOX], ['Dropdown', DROPDOWN],
      ['Name', NAME], ['Address', ADDRESS], ['Date', DATE], ['Email', EMAIL], ['Time', TIME], ['Phone', PHONE], ['Website', WEBSITE],
      ['Price', PRICE], ['Likert', LIKERT], ['Facebook', FACEBOOK], ['Twitter', TWITTER]]
    end
  end

	# ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  belongs_to :form
  has_attached_file :field_image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  #has_many :field_options, dependent: :destroy
  #accepts_nested_attributes_for :field_options, reject_if: :all_blank, allow_destroy: true


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
  validates_presence_of :name, :field_label, :field_type
  validates_uniqueness_of :name, scope: :form_id
  validates :field_type, inclusion: { in: FieldType.options }
  validates_attachment_content_type :field_image, content_type: %w(image/jpeg image/jpg image/png)
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
  [FieldType::BOOLEAN, FieldType::NUMBER, FieldType::CHECKBOX, FieldType::DROPDOWN, FieldType::NAME, FieldType::ADDRESS,
   FieldType::DATE, FieldType::EMAIL, FieldType::TIME,
   FieldType::PHONE, FieldType::WEBSITE, FieldType::PRICE, FieldType::LIKERT, FieldType::FACEBOOK, FieldType::TWITTER,
   FieldType::MCQ, FieldType::SINGLE_LINE, FieldType::PARAGRAPH, FieldType::RATING, FieldType::BOOLEAN].each do |method|
	  define_method "#{method}?" do
	    self.field_type == method
	  end
  end

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
