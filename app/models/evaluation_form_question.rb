class EvaluationFormQuestion < ActiveRecord::Base
  
  # CONSTANTS
  # ------------------------------------------------------------------------------------------------------
  module QuestionType
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
  belongs_to :evaluation_form
  has_many :question_options, class_name: "Option"
  accepts_nested_attributes_for :question_options


  # ATTRIBUTES
  # ------------------------------------------------------------------------------------------------------
  # hstore
  store_accessor :properties, :scale, :options, :true_label, :false_label


  # SCOPES
  # ------------------------------------------------------------------------------------------------------
  

  # VALIDATIONS
  # ------------------------------------------------------------------------------------------------------
  validates_presence_of :name, :en_label, :question_type
  validates_uniqueness_of :name, scope: :evaluation_form_id
  validates :question_type, inclusion: { in: QuestionType.options }
  # validates :scale, presence: true, numericality: { greater_than: 0 }, if: Proc.new { |question| question.rating? }
  # validates :options, presence: true, length: { maximum: 255 }, if: Proc.new { |question| question.mcq? }
  # validates :true_label, presence: true, length: { maximum: 255 }, if: Proc.new { |question| question.boolean? }
  # validates :false_label, presence: true, length: { maximum: 255 }, if: Proc.new { |question| question.boolean? }


  # CALLBACKS
  # ------------------------------------------------------------------------------------------------------
  before_save :format_attributes


	# INSTANCE METHODS
  # ------------------------------------------------------------------------------------------------------
  [QuestionType::MCQ, QuestionType::SINGLE_LINE, QuestionType::PARAGRAPH, QuestionType::RATING, QuestionType::BOOLEAN].each do |method|
	   define_method "#{method}?" do
	      self.question_type == method
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
