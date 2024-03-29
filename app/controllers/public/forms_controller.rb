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
    begin
      ap params
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

    rescue CarrierWave::IntegrityError => e
      flash[:alert] = e.message
      render action: 'show'
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
      #
      # Stucked with form question_group, the strong parameter not working well with multi level nested attributes into more than 2 levels
      #
      # params.require(:form_entry).permit(:form_id, :answers => form_entry_param)
      #
      params.require(:form_entry).permit!
    end

    # Return allowed params for form entry
    # The returned is Array and the value is depend how much fields and field types in form
    # -----------------------------------------------------------------------------------------
    #
    def form_entry_param
      Array.new.tap do |arr|
        form.fields.map do |field|
          if field.field_type_range?
            arr << { field.id.to_s => [:from, :to] }

          elsif field.field_type_datetime?
            arr << { field.id.to_s => [:date, :hours, :minutes] }

          elsif field.field_type_address?
            arr << { field.id.to_s => [:address, :city, :postal_code, :country] }

          elsif field.field_type_question_group?
            # TO DO
            arr << { 'field.id' => [ 'row_10' ] }

          elsif field.field_type_checkbox? || field.field_type_mcq?
            arr << { field.id.to_s => [] }

          elsif field.field_type_statement?
            # TO DO
            field.properties['statements'].each do |key, value|
              arr << field.id.to_s + "_#{key}"
            end

          elsif field.field_type_file?
            arr << field.id.to_s

          else
            arr << field.id.to_s
          end
        end
      end
    end

end