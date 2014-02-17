class FormsController < ApplicationController
  add_abilities_for(Form)
  before_action :set_form, only: [:edit, :update, :destroy]
  set_tab "forms"

  def index
    @forms = current_user.forms.order('name')
  end

  def show
  	@form = Form.find(params[:id])
  end

  def new
    @form = Form.new
  end

  def edit
  end

  def create
    @form = Form.new(safe_params)
    @form.user_id = current_user.id

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

  def summary
    @form = Form.includes(:fields).find(params[:id])
  end

  def report
    @form = Form.find(params[:id])
    @entries = @form.entries
  end

  private

    def set_form
      @form = Form.find(params[:id])
      check_authz_for(@form)
    end

    def safe_params
      params.require(:form).permit(:name, :active, :scope, :introduction, :confirmation_message, :max_entries_allowed, :end_date,
      	                           fields_attributes: [:id, :name, :required, :en_label, :fr_label, :en_hint, :fr_hint, :field_type, :scale, :true_label, :false_label, :_destroy,
                                   field_options_attributes: [:id, :name, :_destroy] ])
    end
end
