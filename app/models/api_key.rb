class ApiKey < ActiveRecord::Base

	# ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  belongs_to :user


  # VALIDATIONS
  # ------------------------------------------------------------------------------------------------------
  validates_presence_of :access_token, :name
  validates_uniqueness_of :access_token

end