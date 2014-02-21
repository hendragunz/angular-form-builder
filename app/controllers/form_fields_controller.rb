class FormFieldsController < ApplicationController

  def new
  	@field = FormField.new

  	respond_to do |format|
      format.html
      format.js
    end
  end

end