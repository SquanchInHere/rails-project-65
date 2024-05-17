# frozen_string_literal: true

module AuthManagement
  extend ActiveSupport::Concern
  included do
    helper_method :current_user

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def check_admin
      return if current_user&.admin?

      redirect_to root_path, notice: t('.notice')
    end

    def check_current_user
      return if current_user

      redirect_to root_path, notice: t('.notice')
    end

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def user_not_authorized
      flash[:alert] = t('.alert')
      redirect_back(fallback_location: root_path)
    end
  end
end
