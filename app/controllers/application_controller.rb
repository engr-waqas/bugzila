# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name type])
  end

  private

  def user_not_authorized
    redirect_to(root_path, alert: 'You are not authorized to perform this action. ')
  end

  def record_not_found
    redirect_to(root_path, alert: 'Record Not Found! ')
  end
end
