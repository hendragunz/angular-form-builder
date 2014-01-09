class EvaluationFormQuestion < ActiveRecord::Base
  
  # CONSTANTS
  # ------------------------------------------------------------------------------------------------------
  module QuestionType
    MCQ        = 'mcq'
    LONG_TEXT  = 'long_text'
    BOOLEAN    = 'boolean'

    def self.options
      [['MCQ', MCQ], ['Long Text', LONG_TEXT], ['Yes/No', BOOLEAN]]
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
  validates :question_type, inclusion: { in: [QuestionType::MCQ, QuestionType::LONG_TEXT, QuestionType::BOOLEAN] }


  # CALLBACKS
  # ------------------------------------------------------------------------------------------------------


	# INSTANCE METHODS
  # ------------------------------------------------------------------------------------------------------
  [QuestionType::MCQ, QuestionType::LONG_TEXT, QuestionType::BOOLEAN].each do |method|
	   define_method "#{method}?" do
	      self.question_type == method
	   end
  end

  def can_be_deleted?
  	true
  end

end
