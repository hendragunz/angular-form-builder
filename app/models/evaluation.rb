class Evaluation < ActiveRecord::Base
	
	# ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------  
  belongs_to :evaluator, class_name: "User"
  belongs_to :resident, class_name: "User"
  belongs_to :procedure
  belongs_to :evaluation_form


  # SCOPES
  # ------------------------------------------------------------------------------------------------------


  # VALIDATIONS
  # ------------------------------------------------------------------------------------------------------
  validates_presence_of :date, :procedure_id, :resident_id, :evaluation_form_id


  # CALLBACKS
  # ------------------------------------------------------------------------------------------------------


	# INSTANCE METHODS
  # ------------------------------------------------------------------------------------------------------
  def can_be_deleted?
  	false
  	#evaluations.empty?
  end

end