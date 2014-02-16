class Account < ActiveRecord::Base

  # ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  has_many :users, dependent: :destroy
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"


  # SCOPES
  # ------------------------------------------------------------------------------------------------------


  # VALIDATIONS
  # ------------------------------------------------------------------------------------------------------
  validates_presence_of :owner_id, on: :update


  # CALLBACKS
  # ------------------------------------------------------------------------------------------------------


	# INSTANCE METHODS
  # ------------------------------------------------------------------------------------------------------
  def self.allowed(user, subject)
    rules = []
    return rules unless subject.instance_of?(Account)
    rules << :manage if user && (user.admin? || user == subject.owner)
    rules
  end

  def is_owner?(user)
    owner_id == user.id
  end

  def is_member?(user)
    user.account_id == id
  end

end
