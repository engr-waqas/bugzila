# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::RoutingError, with: :route_not_matched

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name user_type])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name user_type])
  end

  private

  def user_not_authorized
    redirect_to(root_path, alert: 'You are not authorized to perform this action. ')
  end

  def record_not_found
    redirect_to(root_path, alert: 'Record Not Found! ')
  end

  def route_not_matched
    if user_signed_in?
      redirect_to(projects_path, alert: 'Route did not matched! ')
    else
      redirect_to(root_path, alert: 'Route did not matched! ')
    end
  end
end
