class Evaluation < ActiveRecord::Base

	# ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  belongs_to :evaluation_form
  has_many :questions, through: :evaluation_form

  #belongs_to_hstore :answers, :question


  # ATTRIBUTES
  # ------------------------------------------------------------------------------------------------------
  # using hstore
  store_accessor :answers


  # SCOPES
  # ------------------------------------------------------------------------------------------------------


  # VALIDATIONS
  # ------------------------------------------------------------------------------------------------------
  validates_presence_of :evaluation_form_id #, :resident_id, :procedure_id
  #validate :validate_answers


  # CALLBACKS
  # ------------------------------------------------------------------------------------------------------


	# INSTANCE METHODS
  # ------------------------------------------------------------------------------------------------------
  def can_be_deleted?
  	false
  end

  def validate_answers
    answers.each do |answer|
      if answer.required? && answer[answer.name].blank?
        errors.add answer.name, "can't be blank"
      end
    end
  end

end