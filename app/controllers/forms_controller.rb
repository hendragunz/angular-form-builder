class FormsController < ApplicationController
  before_action :set_form, only: [:edit, :update, :destroy]
  set_tab "forms"

  def index
    @forms = Form.order('name')
  end

  def show
  	@form = Form.includes(:fields).find(params[:id])
  end

  def new
    @form = Form.new
  end

  def edit
  end

  def create
    @form = Form.new(safe_params)
    #@form.creator_id = current_user.id

    respond_to do |format|
      if @form.save
        format.html { redirect_to form_path(@form), notice: 'Form was successfully created.' }
        format.json { render action: 'show', status: :created, location: @form }
      else
        format.html { render action: 'new' }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @form.update(safe_params)
        format.html { redirect_to form_path(@form), notice: 'Form was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
    	if @form.can_be_deleted?
    		@form.destroy
    		format.html { redirect_to forms_url, notice: 'Form was successfully deleted.' }
        format.json { head :no_content }
    	else
    		format.html { redirect_to forms_url, alert: 'Form can not be deleted because of associated records.' }
    	end
    end
  end

  private
    
    def set_form
      @form = Form.find(params[:id])
    end

    def safe_params
      params.require(:form).permit(:name, :active, :scope, :introduction, :conclusion, :max_entries_allowed, :end_date,
      	                           fields_attributes: [:id, :name, :required, :en_label, :fr_label, :en_hint, :fr_hint, :field_type, :scale, :options, :true_label, :false_label, "_destroy",
                                   field_options_attributes: [:name, "_destroy"] ])
    end
end
