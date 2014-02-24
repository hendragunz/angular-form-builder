class RegistrationsController < BaseController
  before_filter :require_login, only: [:edit, :update]
  layout "public", only: [:new, :create]

  def new
    @account = Account.new
    @user = @account.build_owner
  end

  def create
	  @user = User.new(safe_params)

	  if @user.save
      account = Account.create!(owner_id: @user.id)
      @user.update_attributes(account_id: account.id)
	  	auto_login(@user)
      UserMailer.welcome(@user).deliver

      redirect_to root_url
    else
     render :new
	  end
	end

	def edit
		@user = current_user
	end

	def update
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    @user = User.find(current_user.id)

    respond_to do |format|
      if @user.update(safe_params)
        format.html { redirect_to profile_url, notice: "#{t 'registrations.profile_updated', default: 'Profile was successfully updated'}." }
      else
        format.html { render action: "edit" }
      end
    end
	end

  private

    def safe_params
      params.require(:user).permit(:email, :first_name, :last_name, :password)
    end

end