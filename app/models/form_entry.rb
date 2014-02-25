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
  validate :validate_answers


  # CALLBACKS
  # ------------------------------------------------------------------------------------------------------


	# INSTANCE METHODS
  # ------------------------------------------------------------------------------------------------------
  def validate_answers
    self.form.fields.each do |field|
      if field.required and field.field_type == "mcq"
        mcq_value_exist = 0
        field .field_options.each do |option|
          mcq_value_exist = 1 if answers[field.id.to_s+"_"+option.id.to_s] != "0"
        end
        errors.add field.name, "Can't be blank" if mcq_value_exist == 0
      elsif field.required and answers[field.id.to_s].blank?
        errors.add field.name, "Can't be blank"
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

  def can_be_deleted?
    false
  end

  def self.to_csv(options = {})
    headers = %w{ID Answers IP Date}
    header_indexes = Hash[headers.map.with_index{|*x| x}]

    CSV.generate(options) do |csv|
      csv << headers
      all.each do |entry|
        data = {}
        data["ID"]      = entry.id
        data["Answers"] = entry.answers
        data["IP"] = entry.remote_ip
        data["Date"]    = entry.created_at

        row = []
        header_indexes.each do |field, index|
          row << data[field] || ''
        end
        csv << row
      end
    end
  end

end