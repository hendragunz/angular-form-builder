class Form < ActiveRecord::Base

	# ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  has_many :fields, class_name: "FormField", dependent: :destroy
  accepts_nested_attributes_for :fields, reject_if: :all_blank, allow_destroy: true

  belongs_to :creator, class_name: "User"
  has_many :entries, class_name: "FormEntry", dependent: :destroy


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
  before_create :set_slug


	# INSTANCE METHODS
  # ------------------------------------------------------------------------------------------------------
  def to_param
    slug
  end

  def can_be_deleted?
  	#entries.empty?
    true
  end

  def self.allowed(user, subject)
    rules = []
    return rules unless subject.instance_of?(Form)
    rules << :manage if user && (user.account.is_owner?(user) || user == subject.creator)
    rules
  end

  def is_inactive?
    (start_date.present? && start_date < Time.now) && (end_date.present? && end_date > Time.now)
  end

  def has_reached_max_entries?
    entries.length >= max_entries_allowed if max_entries_allowed.present?
  end

  def tiny_url
    
  end

  private

    def set_slug
      return if slug.present?
      begin
        self.slug = SecureRandom.hex(4)
      end while self.class.exists?(slug: self.slug)
    end

end