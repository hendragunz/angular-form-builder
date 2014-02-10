class FormField < ActiveRecord::Base

  # CONSTANTS
  # ------------------------------------------------------------------------------------------------------
  module FieldType
    MCQ          = 'mcq'
    SINGLE_LINE  = 'single_line'
    PARAGRAPH    = 'paragraph'
    RATING       = 'rating'
    BOOLEAN      = 'boolean'

    def self.options
      [ RATING, MCQ, SINGLE_LINE, PARAGRAPH, BOOLEAN ]
    end
    def self.options_with_label
      [ ['MCQ', MCQ], ['Single Line Text', SINGLE_LINE], ['Paragraph Text', PARAGRAPH], ['Rating', RATING], ['Yes/No', BOOLEAN] ]
    end
  end


	# ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  belongs_to :form
  has_many :field_options, dependent: :destroy
  accepts_nested_attributes_for :field_options


  # ATTRIBUTES
  # ------------------------------------------------------------------------------------------------------
  # hstore
  store_accessor :properties, :scale, :options, :true_label, :false_label


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

  private

    def format_attributes
    	self.name = name.underscore
    end

end
