module Enum
  module FormField
    FIELD_TYPE = {
      options: [:single_line, :boolean, :paragraph, :mcq, :rating, :number, :checkbox, :dropdown, :name, :address, :date, :datetime, :email, :time, :phone, :website, :price, :statement, :facebook, :twitter, :file, :picture_choice, :section, :range],
      default: :single_line
    }
  end
end