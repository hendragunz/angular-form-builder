# == Schema Information
#
# Table name: forms
#
#  id                        :integer          not null, primary key
#  name                      :string(255)
#  slug                      :string(255)      not null
#  introduction              :text
#  confirmation_message      :text
#  max_entries_allowed       :integer
#  unique_ip_only            :boolean          default(FALSE)
#  send_email_confirmation   :boolean          default(FALSE)
#  show_questions_one_by_one :boolean          default(FALSE)
#  start_date                :datetime
#  end_date                  :datetime
#  entries_count             :integer          default(0)
#  user_id                   :integer
#  created_at                :datetime
#  updated_at                :datetime
#

class Form < ActiveRecord::Base

	# ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  has_many :fields, class_name: "FormField", dependent: :destroy
  accepts_nested_attributes_for :fields, reject_if: :all_blank, allow_destroy: true

  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  has_many :entries, class_name: "FormEntry", dependent: :destroy


  # SCOPES
  # ------------------------------------------------------------------------------------------------------
  scope :active,   -> { where(active: true) }
  scope :inactive, -> { where(active: false) }


  # VALIDATIONS
  # ------------------------------------------------------------------------------------------------------
  validates :name,  presence: true,
                    uniqueness: { scope: 'user_id', case_sensitve: false }
  validates_length_of :persons_to_notify, maximum: 255, allow_blank: true


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
    rules << :manage if user && user == subject.creator
    rules
  end

  def is_inactive?
    (start_date.present? && start_date < Time.now) && (end_date.present? && end_date > Time.now)
  end

  def has_reached_max_entries?
    entries.length >= max_entries_allowed if max_entries_allowed.present?
  end

  def has_not_unique_ip(request, user)
    if self.unique_ip_only and (!user.account.is_owner?(user) or user.id != user_id)
      FormEntry.where(form_id: self.id).each do |entry|
        return true if entry.user_info[:remote_ip] == request.remote_ip
      end
    end
    false
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
