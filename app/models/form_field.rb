# == Schema Information
#
# Table name: form_fields
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  field_label :text
#  field_hint  :text
#  field_type  :string(255)
#  properties  :hstore
#  scale       :integer
#  options     :string(255)
#  required    :boolean          default(FALSE)
#  position    :integer          default(0)
#  form_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  size        :string(255)
#  page        :integer          default(1), not null
#  show_to     :string(255)
#

class FormField < ActiveRecord::Base
  include FieldTypeCollection

  # ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  belongs_to  :form
  has_many    :field_options, dependent: :destroy

  # ACCEPT NESTED ATTRIBUTES
  # ------------------------------------------------------------------------------------------------------
  accepts_nested_attributes_for :field_options, reject_if: :all_blank, allow_destroy: true


  # ATTRIBUTES
  # ------------------------------------------------------------------------------------------------------
  # hstore
  # store_accessor :properties, :currency, :scale_rate, :scale_type, :true_label, :false_label, :options, :likert_rows, :likert_columns
  serialize :properties, ActiveRecord::Coders::NestedHstore


  # SCOPES
  # ------------------------------------------------------------------------------------------------------
  default_scope { order('position') }


  # VALIDATIONS
  # ------------------------------------------------------------------------------------------------------
  validates :name,        presence: true,
                          uniqueness: { scope: :form_id, case_sensitive: false }
  validates :field_label, presence: true


  # CALLBACKS
  # ------------------------------------------------------------------------------------------------------
  before_save :format_attributes
  before_destroy :check_for_entries


	# INSTANCE METHODS
  # ------------------------------------------------------------------------------------------------------

  def as_json(options = {})
    super(options).merge(persisted: persisted?, field_options: field_options.map{|x| x.as_json})
  end

  # def properties_columns
  #   JSON.parse(properties['columns']) rescue []
  # end

  # def properties_statements
  #   JSON.parse(properties['statements']) rescue []
  # end

  private

    def format_attributes
    	self.name = name.underscore
    end

    def check_for_entries
      form.entries.each do |entry|
        entry.answers = entries.answers.reject{ |k| k.split('_').first == self.id.to_s }
        entries.save
      end
    end

end
