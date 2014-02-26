class Public::FormsController < Public::BaseController
	before_filter :load_form
  layout 'public_form'

  def show
  	if @form
  		@entry = @form.entries.new
      @questions = @form.fields.order('position')
  	end
  end

  def create
    @entry = @form.entries.new(safe_params)
    @entry.track_user(request)

    respond_to do |format|
      if @entry.save
        format.html { redirect_to completed_public_form_path(@form) }
        format.json { render action: 'show', status: :created, location: @entry }
      else
        format.html { render action: 'new' }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def completed
  end

  private

    def load_form
    	@form = Form.find_by_slug(params[:id])
    end

    def safe_params
      params.require(:form_entry).permit(:form_id, :answers, :answers_attributes).tap do |whitelisted|
        whitelisted[:answers] = params[:form_entry][:answers]
      end
    end

end