class Admin::UsersController < Admin::BaseController
	set_tab 'admin'
	helper_method :sort_column, :sort_direction

  def index
  	@users = current_account.users.exclude_users(current_user).order(sort_column + " " + sort_direction).page(params[:page]).per(15)
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(safe_params)
    random_password = SecureRandom.hex(4)
    @user.password = random_password
    @user.password_confirmation = random_password
    @user.account_id = current_account.id

    respond_to do |format|
      if @user.save
        UserMailer.new_account_member(@user, random_password).deliver
        format.html { redirect_to admin_users_url, notice: "#{@user.full_name} #{t 'is_now_created', default: 'created'}. #{t 'an_email_was_sent_to', default: 'An email was sent to'} #{@user.email}." }
      else
        format.html { render action: "new" }
      end
    end
  end

  def toggle_status
  	@user = User.find(params[:id])
    @user.toggle_status
    render layout: false
  end

  private

    def safe_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end

	  def sort_direction
	    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
	  end

	  def sort_column
	    User.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
	  end
end