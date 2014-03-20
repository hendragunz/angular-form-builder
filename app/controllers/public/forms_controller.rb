class Public::FormsController < Public::BaseController
  layout 'public_form'

  # GET -
  #
  def show
		@entry      = form.entries.new
    @questions  = form.fields.order('position')
  end


  # POST -
  #
  def create
    # ap params
    # ap safe_params

    @entry = form.entries.new(safe_params)
    @entry.track_user(request)

    respond_to do |format|
      if @entry.save
        format.html { redirect_to completed_public_form_path(form) }
        format.json { render action: 'completed', status: :created, location: @entry }
        FormEntryMailer.notify_recipient(@entry).deliver if @entry.form.persons_to_notify.present?
      else
        format.html {
          flash.now[:alert] = @entry.errors.full_messages.join("<br />").html_safe
          render action: 'show'
        }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def completed
    form
  end

  private

    # select form
    #
    def form
    	@form ||= Form.find_by(slug: params[:id])
    end

    def safe_params
      params.require(:form_entry).permit(:form_id, :answers => [
        form.fields.map(&:id).map(&:to_s)
      ])
    end

end