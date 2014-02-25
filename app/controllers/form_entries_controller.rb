class FormEntriesController < BaseController
  before_action :set_form #, only: [:index, :show, :edit, :update, :destroy]
  set_tab "entries"

  def index
    @entries = @form.entries.order('created_at DESC')

    respond_to do |format|
      format.html
      format.csv { send_data @entries.to_csv }
      format.xls # { send_data @products.to_csv(col_sep: "\t") }
    end
  end

  def show
    @entry = FormEntry.find(params[:id])
    @number = params[:index]
  end

  def new
    @entry = @form.entries.new
    @questions = @form.fields.order('position')
  end

  def edit
    @entry = @form.entries.find(params[:id])
    @questions = @form.fields.order('position')
  end

  def create
    @entry = FormEntry.new(safe_params)
    @entry.form_id = @form.id
    @entry.track_user(request)

    respond_to do |format|
      if @entry.save
        format.html { redirect_to form_path(@form), notice: 'Entry was successfully created.' }
        format.json { render action: 'show', status: :created, location: @entry }
      else
        format.html { render action: 'new' }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @entry = @form.entries.find(params[:id])

    respond_to do |format|
      if @entry.update(safe_params)
        format.html { redirect_to form_form_entry_path(@form, @entry), notice: 'Entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @entry = @form.entries.find(params[:id])
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to form_path(@form), notice: 'Entry was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

    def set_form
      @form = Form.find_by_slug(params[:form_id])
    end

    def safe_params
      params.require(:form_entry).permit(:date, :form_id, :answers, :answers_attributes).tap do |whitelisted|
        whitelisted[:answers] = params[:form_entry][:answers]
      end
    end

end
