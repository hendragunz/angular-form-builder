class Admin::UsersController < Admin::BaseController
	set_tab 'admin'
	helper_method :sort_column, :sort_direction

  def index
  	@users = User.includes(:stacks).order(sort_column + " " + sort_direction).page(params[:page]).per(15)
  end

  def show
  	
  end

  private

	  def sort_direction
	    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
	  end

	  def sort_column
	    User.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
	  end
end