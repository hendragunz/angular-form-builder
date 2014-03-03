class FormsController < BaseController
  add_abilities_for(Form)
  before_action :set_form, only: [:show, :edit, :update, :destroy, :notifications, :report]
  before_action :create_hstore_data, only: [:create, :update]
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

  def get_form_fields
    render partial: "forms/fields/"+params[:type]
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

    def create_hstore_data
      if params[:form][:fields_attributes].present?
        params[:form][:fields_attributes].each do |field_data|
          field = field_data.second
          field[:data]= "{option1: 'a', option2: 'b'}" if field['field_type'] == 'mcq'
          field[:data]= "{format: 'words', min: '0', max: '50'}" if field['field_type'] == 'single_line'
          field[:data]= "{format: 'character', min: '0', max: '20'}" if field['field_type'] == 'paragraph'
          field[:data]= "{rate: '5', type: 'star'}" if field['field_type'] == 'rating'
          field[:data]= "{true_label: '', false_label: ''}" if field['field_type'] == 'boolean'
          field[:data]= "{format: 'value', min: '0', max: '10'}" if field['field_type'] == 'number'
          field[:data]= "{choice1: 'a', choice2: 'b'}" if field['field_type'] == 'checkbox'
          field[:data]= "{select1: 'a', select2: 'b'}" if field['field_type'] == 'dropdown'
          field[:data]= "{button_text: 'next'}" if field['field_type'] == 'page_break'
          field[:data]= "{format: 'extended'}" if field['field_type'] == 'name'
          field[:data]= "{format: 'character', min: '0', max: '20', currency: '$'}" if field['field_type'] == 'price'
          field[:data]= "{row1: 'statement 1', row2:'statement 2', column1:'agree', column2: 'disagree'}" if field['field_type'] == 'likert'
        end
      end
    end
end
