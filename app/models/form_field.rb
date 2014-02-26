# == Schema Information
#
# Table name: form_fields
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  en_label   :text
#  fr_label   :text
#  en_hint    :text
#  fr_hint    :text
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
    MCQ          = 'mcq'
    SINGLE_LINE  = 'single_line'
    PARAGRAPH    = 'paragraph'
    RATING       = 'rating'
    BOOLEAN      = 'boolean'
    PRICE        = 'price'

    def self.options
      [ RATING, MCQ, SINGLE_LINE, PARAGRAPH, BOOLEAN, PRICE ]
    end

    def self.options_with_label
      [ ['MCQ', MCQ], ['Single Line Text', SINGLE_LINE], ['Paragraph Text', PARAGRAPH], ['Rating', RATING], ['Yes/No', BOOLEAN], ['Price', PRICE] ]
    end
  end


	# ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  belongs_to :form
  has_many :field_options, dependent: :destroy
  accepts_nested_attributes_for :field_options, reject_if: :all_blank, allow_destroy: true


  # ATTRIBUTES
  # ------------------------------------------------------------------------------------------------------
  # hstore
  store_accessor :properties, :scale, :true_label, :false_label


  # SCOPES
  # ------------------------------------------------------------------------------------------------------


  # VALIDATIONS
  # ------------------------------------------------------------------------------------------------------
  validates_presence_of :name, :en_label, :field_type
  validates_uniqueness_of :name, scope: :form_id
  validates :field_type, inclusion: { in: FieldType.options }
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
  [FieldType::MCQ, FieldType::SINGLE_LINE, FieldType::PARAGRAPH, FieldType::RATING, FieldType::BOOLEAN].each do |method|
	   define_method "#{method}?" do
	      self.field_type == method
	   end
  end

  def can_be_deleted?
  	true
  end

  def as_json(options = {})
    # this example ignores the user's options
    super(options).merge(:persisted => persisted?, :field_options => field_options.map{|x| x.as_json})
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
