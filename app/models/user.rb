class User < ActiveRecord::Base
  authenticates_with_sorcery!

	# ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  belongs_to :account
  has_many :forms, dependent: :destroy
  has_many :api_keys, dependent: :destroy


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
  after_create :generate_api_key


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

    def generate_api_key
      api_keys.create(access_token: SecureRandom.hex, name: 'default')
    end

end
