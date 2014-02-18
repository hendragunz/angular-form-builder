class FormEntry < ActiveRecord::Base

	# ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  belongs_to :form, counter_cache: :entries_count
  has_many :questions, through: :form

  #belongs_to_hstore :answers, :question


  # ATTRIBUTES
  # ------------------------------------------------------------------------------------------------------
  # using hstore
  store_accessor :answers

  # using rails store
  store :user_info, accessors: [ :remote_ip, :browser, :version, :platform ]


  # SCOPES
  # ------------------------------------------------------------------------------------------------------


  # VALIDATIONS
  # ------------------------------------------------------------------------------------------------------
  validates_presence_of :form_id #, :resident_id, :procedure_id
  #validate :validate_answers


  # CALLBACKS
  # ------------------------------------------------------------------------------------------------------


	# INSTANCE METHODS
  # ------------------------------------------------------------------------------------------------------
  def validate_answers
    answers.each do |answer|
      if answer.required? && answer[answer.name].blank?
        errors.add answer.name, "can't be blank"
      end
    end
  end

  def track_user(request)
    user_agent = UserAgent.parse(request.user_agent)
    self.remote_ip = request.remote_ip
    self.browser = user_agent.browser
    self.version = user_agent.version
    self.platform = user_agent.platform
  end

end