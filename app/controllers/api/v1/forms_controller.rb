module Api
  module V1
    class FormsController < Api::BaseController

      before_action :set_form, only: [:show, :update, :destroy]
      respond_to :json

      # curl -H 'Authorization: Token token=":token"' http://localhost:3009/api/forms
      def index
        respond_with @current_user.forms
      end

      # curl -H 'Authorization: Token token=":token"' http://localhost:3009/api/forms/:slug
      def show
        respond_with @form
      end

      # curl -v -H 'Authorization: Token token=":token"' -H "Content-type: application/json" -X POST -d '{"form": {"name":"My Form"}}' http://localhost:3009/api/forms
      def create
        @form = @current_user.forms.create(safe_params)
        respond_with :api, @form
      end

      # curl -v -H 'Authorization: Token token=":token"' -H "Content-type: application/json" -X PUT -d '{"form": {"name":"Form A"}}' http://localhost:3009/api/forms/:slug
      def update
        @form.update(safe_params)
        respond_with :api, @form
      end

      # curl -v -H 'Authorization: Token token=":token"' -H "Content-type: application/json" -X DELETE http://localhost:3009/api/forms/:slug
      def destroy
        respond_with @form.destroy
      end

      private

        def set_form
          @form = Form.where(slug: params[:id]).first
        end

        def safe_params
          params.require(:form).permit(:name)
        end

    end
  end
end