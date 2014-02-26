# == Schema Information
#
# Table name: users
#
#  id                              :integer          not null, primary key
#  email                           :string(255)
#  first_name                      :string(255)
#  last_name                       :string(255)
#  admin                           :boolean          default(FALSE)
#  active                          :boolean          default(TRUE)
#  account_id                      :integer
#  localization                    :string(255)      default("fr")
#  crypted_password                :string(255)
#  salt                            :string(255)
#  created_at                      :datetime
#  updated_at                      :datetime
#  remember_me_token               :string(255)
#  remember_me_token_expires_at    :datetime
#  reset_password_token            :string(255)
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  access_token                    :string(255)
#

class User < ActiveRecord::Base
  authenticates_with_sorcery!

	# ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  belongs_to :account
  has_many :forms, dependent: :destroy


  # SCOPES
  # ------------------------------------------------------------------------------------------------------
  scope :exclude_users, ->(user_ids) { where("id NOT IN (?)", user_ids) }


  # VALIDATIONS
  # ------------------------------------------------------------------------------------------------------
  validates_uniqueness_of :email
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/
  validates_presence_of :email, :first_name, :last_name
  validates_presence_of :password, on: :create
  validates_length_of :password, minimum: 6, if: :password
  validates_confirmation_of :password, if: :password


  # CALLBACKS
  # ------------------------------------------------------------------------------------------------------
  before_create :format_fields
  before_create :generate_access_token


	# INSTANCE METHODS
  # ------------------------------------------------------------------------------------------------------
  def full_name
  	"#{first_name} #{last_name}"
  end

  def name_with_email
    "#{full_name} <#{email}>"
  end

  def format_fields
    email.downcase
    first_name.titleize
    last_name.titleize
  end

  def toggle_status
    self.active = !active
    save!
  end

  private

    def generate_access_token
      begin
        self.access_token = SecureRandom.hex
      end while self.class.exists?(access_token: access_token)
    end

end
