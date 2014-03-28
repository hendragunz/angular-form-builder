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
      when 'single_line', 'paragraph', 'facebook', 'twitter', 'phone', 'website', 'radio', 'date', 'picture_choice', 'rating'
        if field.required && answers[field.id.to_s].blank?
          errors[:base] << "#{field.field_label} can't be blank"
        end


      when 'checkbox', 'mcq'
        if field.required && (answers[field.id.to_s] || []).reject(&:blank?).blank?
          errors[:base] << "#{field.field_label} can't be blank"
        end


      when 'statement'
        if field.required
          field.properties['statements'].each do |key, statement|
            if answers[field.id.to_s + "_#{key}"].blank?
              errors[:base] << "Question group for #{statement['name']} can't be blank"
            end
          end
        end

      when 'price'
        if field.required && answers[field.id.to_s].blank?
          errors[:base] << "#{field.field_label} can't be blank"
        end

        if answers[field.id.to_s].present? && answers[field.id.to_s].try(:to_f) < 0
          errors[:base] << "#{field.field_label} should be greater or equal then 0"
        end

      when 'number'
        if field.required && answers[field.id.to_s].blank?
          errors[:base] << "#{field.field_label} can't be blank"
        end

        if answers[field.id.to_s].present?
          value = answers[field.id.to_s].to_f

          from_number = field.properties['from_number'].to_f
          if (from_number != 0.0) && (value < from_number)
            errors[:base] << "#{field.field_label} can't be lower than #{ from_number }"
          end

          to_number   = field.properties['to_number'].to_f
          if (to_number != 0.0) && (value > to_number)
            errors[:base] << "#{field.field_label} can't be greather than #{ to_number }"
          end
        end

      when 'website'
        if field.required && answers[field.id.to_s].blank?
          errors[:base] << "#{field.field_label} can't be blank"
        end


      when 'percentage'
        if field.required && answers[field.id.to_s].blank?
          errors[:base] << "#{field.field_label} can't be blank"
        end

        if answers[field.id.to_s].present?
          value = answers[field.id.to_s].to_f

          if (value < 0.0)
            errors[:base] << "#{field.field_label} can't be lower than 0.0 %"
          end

          if (value > 100.0)
            errors[:base] << "#{field.field_label} can't be greather than 100.0 %"
          end
        end


      when 'range'
        if field.required && (answers[field.id.to_s + '_from'].blank? || answers[field.id.to_s + '_to'].blank?)
          errors[:base] << "#{field.field_label} can't be blank"
        end

        if answers[field.id.to_s+'_from'].present? && answers[field.id.to_s+'_to'].present?
          value1 = answers[field.id.to_s+'_from'].to_f
          value2 = answers[field.id.to_s+'_to'].to_f

          from_number = field.properties['from_number'].to_f
          if (from_number != 0.0) && (value1 < from_number)
            errors[:base] << "#{field.field_label} for from number can't be lower than #{ from_number }"
          end

          to_number   = field.properties['to_number'].to_f
          if (to_number != 0.0) && (value2 > to_number)
            errors[:base] << "#{field.field_label} for to number can't be greather than #{ to_number }"
          end
        end

      when 'email'
        if field.required && answers[field.id.to_s].blank?
          errors[:base] << "#{field.field_label} can't be blank"
        end

        if answers[field.id.to_s].present? && answers[field.id.to_s].match(/\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/).blank?
          errors[:base] << "#{field.field_label} is not valid email format"
        end

      when 'datetime'
        if field.required
          if answers[field.id.to_s].blank? || answers[field.id.to_s + '_hours'].blank? || answers[field.id.to_s + '_minutes'].blank?
            errors[:base] << "#{field.field_label} for date, hours, and minutes can't be blank"
          end
        end

      when 'address'
        if field.required
          if answers[field.id.to_s + '_address'].blank? || answers[field.id.to_s + '_city'].blank?
            errors[:base] << "#{field.field_label} address can't be blank"
          end
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
