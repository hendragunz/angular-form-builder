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


  # CALLBACKS
  # ------------------------------------------------------------------------------------------------------
  before_validation :process_answers


	# INSTANCE METHODS
  # ------------------------------------------------------------------------------------------------------

  # cache the fields in variable
  def fields
    @fields ||= form.fields
  end


  def validate_answers
    fields.each_with_index do |field, idx|
      case field.field_type
      when 'single_line', 'paragraph', 'facebook', 'twitter', 'phone', 'website', 'radio', 'date', 'picture_choice', 'dropdown', 'rating', 'boolean'
        if field.required && answers[field.id.to_s].blank?
          errors[:base] << "#{idx+1}) #{field.field_label} #{I18n.t 'errors.cant_be_blank'}"
        end

      when 'checkbox', 'mcq'
        if field.required && (answers[field.id.to_s] || []).reject(&:blank?).blank?
          errors[:base] << "#{idx+1}) #{field.field_label} #{I18n.t 'errors.cant_be_blank'}"
        end

      when 'statement'
        if field.required
          field.properties['statements'].each do |key, statement|
            if answers[field.id.to_s + "_#{key}"].blank?
              errors[:base] << "#{idx+1}) #{statement['name']} #{I18n.t 'errors.cant_be_blank'}"
            end
          end
        end

      when 'price'
        if field.required && answers[field.id.to_s].blank?
          errors[:base] << "#{idx+1}) #{field.field_label} #{I18n.t 'errors.cant_be_blank'}"
        end

        if answers[field.id.to_s].present? && answers[field.id.to_s].try(:to_f) < 0
          errors[:base] << "#{idx+1}) #{field.field_label} should be greater or equal than 0"
        end

      when 'website'
        if field.required && answers[field.id.to_s].blank?
          errors[:base] << "#{idx+1}) #{field.field_label} #{I18n.t 'errors.cant_be_blank'}"
        end

      when 'percentage', 'number'
        if field.required && answers[field.id.to_s].blank?
          errors[:base] << "#{idx+1}) #{field.field_label} #{I18n.t 'errors.cant_be_blank'}"
        end

        if answers[field.id.to_s].present? && field.properties['from_number'].present? && field.properties['to_number'].present?
          value       = answers[field.id.to_s].to_f
          from_number = field.properties['from_number'].to_f
          to_number   = field.properties['to_number'].to_f

          if (value < from_number)
            errors[:base] << "#{idx+1}) #{field.field_label} can't be lower than #{ from_number }"
          end

          if (value > to_number)
            errors[:base] << "#{idx+1}) #{field.field_label} #{I18n.t 'errors.cant_be_greater_than'} #{ to_number }"
          end
        end

      when 'range'
        if field.required && (answers[field.id.to_s]['from'].blank? || answers[field.id.to_s]['to'].blank?)
          errors[:base] << "#{idx+1}) #{field.field_label} #{I18n.t 'errors.cant_be_blank'}"
        end

        if answers[field.id.to_s]['from'].present? && answers[field.id.to_s]['to'].present?
          value1 = answers[field.id.to_s]['from'].to_f
          value2 = answers[field.id.to_s]['to'].to_f

          from_number = field.properties['from_number'].to_f
          to_number   = field.properties['to_number'].to_f

          if ((from_number != 0.0) && ((value1 <= from_number) || (value1 >= to_number))) || ((to_number != 0.0) && ((value2 >= to_number) || (value2 <= from_number)))
            errors[:base] << "#{idx+1}) #{field.field_label} values should be between #{ from_number.to_i } and #{ to_number.to_i }"
          end
        end

      when 'email'
        if field.required && answers[field.id.to_s].blank?
          errors[:base] << "#{idx+1}) #{field.field_label} #{I18n.t 'errors.cant_be_blank'}"
        end

        if answers[field.id.to_s].present? && answers[field.id.to_s].match(/\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/).blank?
          errors[:base] << "#{idx+1}) #{field.field_label} is not a valid email format"
        end

      when 'datetime'
        if field.required
          if answers[field.id.to_s]['date'].blank? || answers[field.id.to_s]['hours'].blank? || answers[field.id.to_s]['minutes'].blank?
            errors[:base] << "#{idx+1}) #{field.field_label} for date, hours, and minutes #{I18n.t 'errors.cant_be_blank'}"
          end
        end

      when 'address'
        if field.required
          if answers[field.id.to_s + '_address'].blank? || answers[field.id.to_s + '_city'].blank?
            errors[:base] << "#{idx+1}) #{field.field_label} address #{I18n.t 'errors.cant_be_blank'}"
          end
        end

      when 'question_group'
        if field.required
          if answers[field.id.to_s].blank?
            errors[:base] << "#{idx+1}) #{field.field_label} #{I18n.t 'errors.cant_be_blank'}"
          end

          if answers[field.id.to_s].present?
            answers[field.id.to_s].each do |key, row|
              if row.values.include?("")
                errors[:base] << "#{idx+1}) #{field.field_label}'s rows #{I18n.t 'errors.cant_be_blank'}"
                return
              end
            end
          end
        end
      end


      # if field.required and field.field_type == "mcq"
      #   mcq_value_exist = 0
      #   field .field_options.each do |option|
      #     mcq_value_exist = 1 if answers[field.id.to_s+"_"+option.id.to_s] != "0"
      #   end
      #   errors.add field.name, "#{I18n.t 'errors.cant_be_blank'}" if mcq_value_exist == 0
      # elsif field.required and answers[field.id.to_s].blank?
      #   errors.add field.name, "#{I18n.t 'errors.cant_be_blank'}"
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

  private

    # Callback to process answer entries for all types that need a process
    #
    def process_answers
      if self.answers.present?
        fields.each do |field|
          # remove question group's row that has empty value (row with empty value)
          if field.field_type_question_group?
            self.answers[field.id.to_s] = Hash.new.tap do |hash|
              answers[field.id.to_s].each do |key, value|
                hash[key] = value if answers[field.id.to_s][key].values.reject(&:blank?).present?
              end
            end

          # remove nil values
          elsif field.field_type_mcq? || field.field_type_checkbox?
            self.answers[field.id.to_s] =  if self.answers[field.id.to_s].is_a?(String)
                                             JSON.parse(self.answers[field.id.to_s]).reject(&:blank?).uniq
                                           elsif self.answers[field.id.to_s].is_a?(Array)
                                             self.answers[field.id.to_s].reject(&:blank?).uniq
                                           end

          # Process to store attachment file
          elsif field.field_type_file?
            data = self.answers[field.id.to_s]
            if data.present?
              uploader = AttachmentUploader.new
              uploader.question_id = field.id.to_s
              uploader.form_id = form_id
              uploader.store!(data)
              self.answers[field.id.to_s] = uploader.url
            end
          end
        end
      end
    end

end
