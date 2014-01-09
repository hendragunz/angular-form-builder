class Admin::EvaluationFormsController < Admin::BaseController
  before_action :set_evaluation_form, only: [:edit, :update, :destroy]
  set_tab "evaluation_forms"

  def index
    @evaluation_forms = EvaluationForm.order('name')
  end

  def show
  	@evaluation_form = EvaluationForm.includes(:questions).find(params[:id])
  end

  def new
    @evaluation_form = EvaluationForm.new
  end

  def edit
  end

  def create
    @evaluation_form = EvaluationForm.new(safe_params)
    #@evaluation_form.creator_id = current_user.id

    respond_to do |format|
      if @evaluation_form.save
        format.html { redirect_to admin_evaluation_forms_url(@evaluation_form), notice: 'Evaluation form was successfully created.' }
        format.json { render action: 'show', status: :created, location: @evaluation_form }
      else
        format.html { render action: 'new' }
        format.json { render json: @evaluation_form.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @evaluation_form.update(safe_params)
        format.html { redirect_to admin_evaluation_form_path(@evaluation_form), notice: 'Evaluation form was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @evaluation_form.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
    	if @evaluation_form.can_be_deleted?
    		@evaluation_form.destroy
    		format.html { redirect_to admin_evaluation_forms_url, notice: 'Evaluation form was successfully deleted.' }
        format.json { head :no_content }
    	else
    		format.html { redirect_to admin_evaluation_forms_url, alert: 'Evaluation form can not be deleted because of associated records.' }
    	end
    end
  end

  private
    
    def set_evaluation_form
      @evaluation_form = EvaluationForm.find(params[:id])
    end

    def safe_params
      params.require(:evaluation_form).permit(:name, :active, :scope, :introduction, :conclusion,
      	                                      questions_attributes: [:id, :en_name, :fr_name, :en_hint, :fr_hint, :question_type, :scale, "_destroy"])
    end
end
