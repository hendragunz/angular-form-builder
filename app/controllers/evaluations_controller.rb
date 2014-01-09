class EvaluationsController < ApplicationController
  before_action :set_evaluation, only: [:show, :edit, :update, :destroy]
  set_tab "evaluations"

  def index
    @evaluations = Evaluation.all
  end

  def show
  end

  def new
    @evaluation = Evaluation.new
  end

  def edit
  end

  def create
    @evaluation = Evaluation.new(safe_params)

    respond_to do |format|
      if @evaluation.save
        format.html { redirect_to @evaluation, notice: 'Evaluation was successfully created.' }
        format.json { render action: 'show', status: :created, location: @evaluation }
      else
        format.html { render action: 'new' }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @evaluation.update(safe_params)
        format.html { redirect_to @evaluation, notice: 'Evaluation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @evaluation.destroy
    respond_to do |format|
      format.html { redirect_to evaluations_url }
      format.json { head :no_content }
    end
  end

  private

    def set_evaluation
      @evaluation = Evaluation.find(params[:id])
    end

    def safe_params
      params.require(:evaluation).permit(:date, :procedure_id, :evaluation_form_id, :evaluator_id, :resident_id)
    end
end
