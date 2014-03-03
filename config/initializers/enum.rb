module Enum
  module FormField
    FIELD_TYPE = {
      options: [:single_line, :boolean, :paragraph, :mcq, :rating, :number, :checkbox, :dropdown, :name, :address, :date, :email, :time, :phone, :website, :price, :likert, :facebook, :twitter, :file],
      default: :single_line
    }
  end
end