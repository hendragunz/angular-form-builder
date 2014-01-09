class EvaluationForm < ActiveRecord::Base

	# ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  has_many :questions, class_name: "EvaluationFormQuestion", dependent: :destroy
  accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true
  
  belongs_to :creator, class_name: "User"

  has_many :evaluations, dependent: :destroy


  # SCOPES
  # ------------------------------------------------------------------------------------------------------
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }


  # VALIDATIONS
  # ------------------------------------------------------------------------------------------------------
  validates_presence_of :name
  validates_uniqueness_of :name


  # CALLBACKS
  # ------------------------------------------------------------------------------------------------------


	# INSTANCE METHODS
  # ------------------------------------------------------------------------------------------------------
  def can_be_deleted?
  	evaluations.empty?
  end

end