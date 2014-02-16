#encoding: utf-8
module Authz
  extend ActiveSupport::Concern

  module ClassMethods
    def add_abilities_for(klass)
      before_filter do |c|
        abilities << klass
      end
    end
  end

  included do
    def check_authz_for(object)
      raise ActionController::RoutingError.new('Page not found.') unless can?(current_user, :manage, object)
    end
  end
end