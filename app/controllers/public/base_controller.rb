class Public::BaseController < BaseController
	skip_before_filter :require_login
	layout "public"
end
