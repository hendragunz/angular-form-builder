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
    # ap form_entry_param
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
      return {} if params[:form_entry].blank?
      params.require(:form_entry).permit(:form_id, :answers => form_entry_param)
    end

    # Return allowed params for form entry
    # The returned is Array and the value is depend how much fields and field types in form
    # -----------------------------------------------------------------------------------------
    #
    def form_entry_param
      Array.new.tap do |arr|
        form.fields.map do |field|
          if field.field_type_range?
            arr << field.id.to_s + '_from'
            arr << field.id.to_s + '_to'

          elsif field.field_type_datetime?
            arr << field.id.to_s
            arr << field.id.to_s + '_hours'
            arr << field.id.to_s + '_minutes'

          elsif field.field_type_address?
            arr << field.id.to_s
            arr << field.id.to_s + '_address'
            arr << field.id.to_s + '_city'
            arr << field.id.to_s + '_postal_code'
            arr << field.id.to_s + '_country'

          elsif field.field_type_question_group?
            field.properties['groups'].each do |key, value|
              arr << field.id.to_s
              arr << field.id.to_s + "_#{key}"
            end

          elsif field.field_type_checkbox? || field.field_type_mcq?
            arr << { field.id.to_s => [] }

          elsif field.field_type_statement?
            field.properties['statements'].each do |key, value|
              arr << field.id.to_s + "_#{key}"
            end



          else
            arr << field.id.to_s
          end
        end
      end
    end

end