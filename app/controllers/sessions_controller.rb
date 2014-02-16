class SessionsController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]
  layout "public", only: [:new, :create]

	def new
	end

	def create
	  if params[:session]
	    user = login(params[:session][:email], params[:session][:password], params[:session][:remember_me])
	  else
	  	user = login(params[:email], params[:password], params[:remember_me])
	  end

    respond_to do |format|
      if user && user.active?
		  	format.html { redirect_back_or_to forms_url}
		  else
			  format.html { render :new }
			  flash.now.alert = "#{t 'sessions.error', default: 'Invalid email/password'}."
		  end
    end
	end

	def destroy
	  logout
	  redirect_to login_url #, notice: "#{t 'theme.sessions.signed_out', default: 'Signed out'}."
	end
end