class FormsController < BaseController
  add_abilities_for(Form)
  before_action :set_form, only: [:show, :edit, :update, :destroy, :notifications, :report]
  set_tab "forms"

  def index
    @forms = current_user.forms.order('name')
  end

  def show
  end

  def new
    @form = Form.new
  end

  def edit
    render layout: 'form_builder'
  end

  def create
    @form = Form.new(safe_params)
    @form.user_id = current_user.id

    respond_to do |format|
      if @form.save
        format.html { redirect_to edit_form_path(@form), notice: 'Form was successfully created.' }
        format.json { render action: 'show', status: :created, location: @form }
      else
        format.html { render action: 'new' }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    ap params

    respond_to do |format|
      if @form.update(safe_params)
        format.html { redirect_to form_path(@form), notice: 'Form was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit', layout: 'form_builder' }
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
    @form = Form.includes(:fields).find_by_slug(params[:id])
  end

  def report
    @entries = @form.entries
  end

  def notifications
  end

  private

    def set_form
      @form = Form.find_by_slug(params[:id])
      check_authz_for(@form)
    end

    def safe_params
      params.require(:form).permit(:name, :introduction, :confirmation_message, :max_entries_allowed, :start_date, :end_date, :unique_ip_only, :send_email_confirmation,
                                   :show_questions_one_by_one, :persons_to_notify,
      	                           fields_attributes: [:id, :name, :required, :field_label, :field_hint, :field_type, :scale, :true_label, :false_label, :_destroy, :position,
                                   field_options_attributes: [:id, :name, :_destroy] ])
    end
end
