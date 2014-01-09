class EvaluationFormQuestion < ActiveRecord::Base
  
  # CONSTANTS
  # ------------------------------------------------------------------------------------------------------
  module QuestionType
    MCQ        = 'mcq'
    LONG_TEXT  = 'long_text'
    RATING     = 'rating' 	  	
    BOOLEAN    = 'boolean'

    def self.options
      [ RATING, MCQ, LONG_TEXT, BOOLEAN ]
    end
    def self.options_with_label
      [ ['MCQ', MCQ], ['Long Text', LONG_TEXT], ['Rating', RATING], ['Yes/No', BOOLEAN] ]
    end
  end


	# ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  belongs_to :evaluation_form


  # SCOPES
  # ------------------------------------------------------------------------------------------------------
  

  # VALIDATIONS
  # ------------------------------------------------------------------------------------------------------
  validates_presence_of :en_name, :question_type
  validates :question_type, inclusion: { in: QuestionType.options }
  validates_presence_of :scale, if: Proc.new { |question| question.rating? }


  # CALLBACKS
  # ------------------------------------------------------------------------------------------------------


	# INSTANCE METHODS
  # ------------------------------------------------------------------------------------------------------
  [QuestionType::MCQ, QuestionType::LONG_TEXT, QuestionType::RATING, QuestionType::BOOLEAN].each do |method|
	   define_method "#{method}?" do
	      self.question_type == method
	   end
  end

  def can_be_deleted?
  	true
  end

end
