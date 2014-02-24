class Public::BaseController < ApplicationController
	#skip_before_filter :require_login
	layout "public"
end
