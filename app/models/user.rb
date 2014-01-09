class User < ActiveRecord::Base

	# ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------  
  has_many :sessions, dependent: :destroy
  has_many :evaluations, dependent: :destroy


  # SCOPES
  # ------------------------------------------------------------------------------------------------------


  # VALIDATIONS
  # ------------------------------------------------------------------------------------------------------


  # CALLBACKS
  # ------------------------------------------------------------------------------------------------------


	# INSTANCE METHODS
  # ------------------------------------------------------------------------------------------------------
  def authenticate(password = nil)
    return false unless password
    self.password == password ? true : false
  end
  
  def full_name
  	"#{first_name} #{last_name}"
  end

end
