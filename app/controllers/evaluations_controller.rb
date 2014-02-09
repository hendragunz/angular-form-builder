class EvaluationsController < ApplicationController
  before_action :set_evaluation, only: [:show, :edit, :update, :destroy]
  set_tab "evaluations"

  def index
    @evaluations = Evaluation.order('date DESC')
  end

  def show
  end

  def new
    @evaluation = Evaluation.new(evaluation_form_id: params[:evaluation_form_id])
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
      params.require(:evaluation).permit(:date, :evaluation_form_id).tap do |whitelisted|
        whitelisted[:answers] = params[:evaluation][:answers]
      end
    end

end
