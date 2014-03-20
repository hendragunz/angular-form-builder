# == Schema Information
#
# Table name: form_entries
#
#  id         :integer          not null, primary key
#  form_id    :integer
#  answers    :hstore
#  user_info  :text
#  created_at :datetime
#  updated_at :datetime
#

class FormEntry < ActiveRecord::Base

  # CAPABILITIES
  # ------------------------------------------------------------------------------------------------------
  serialize :answers, ActiveRecord::Coders::NestedHstore


	# ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  belongs_to :form, counter_cache: :entries_count
  has_many :questions, through: :form


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


	# INSTANCE METHODS
  # ------------------------------------------------------------------------------------------------------

  # cache the fields in variable
  def fields
    @fields ||= form.fields
  end


  def validate_answers
    fields.each do |field|
      case field.field_type
      when 'single_line', 'paragraph', 'facebook', 'twitter', 'address', 'phone', 'email', 'website'
        if field.required && answers[field.id.to_s].blank?
          errors[:base] << "#{field.field_label} can't be blank"
        end

      when 'price'
        if field.required && answers[field.id.to_s].blank?
          errors[:base] << "#{field.field_label} can't be blank"
        end

        if answers[field.id.to_s].present? && answers[field.id.to_s].try(:to_f) < 0
          errors[:base] << "#{field.field_label} should be greater or equal then 0"
        end
      end



      # if field.required and field.field_type == "mcq"
      #   mcq_value_exist = 0
      #   field .field_options.each do |option|
      #     mcq_value_exist = 1 if answers[field.id.to_s+"_"+option.id.to_s] != "0"
      #   end
      #   errors.add field.name, "Can't be blank" if mcq_value_exist == 0
      # elsif field.required and answers[field.id.to_s].blank?
      #   errors.add field.name, "Can't be blank"
      # end
    end
  end

  def track_user(request)
    user_agent = UserAgent.parse(request.user_agent)
    self.remote_ip = request.remote_ip
    self.browser = user_agent.browser
    self.version = user_agent.version
    self.platform = user_agent.platform
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
