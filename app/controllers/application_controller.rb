class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  
  private
  
  def require_sign_in
    unless current_user
      flash[:alert] = "You must be logged in to do that."

      redirect_to new_session_path
    end
  end
  
  def authorize_user(can_method, *args)
    unless send(can_method, *args)
      raise Exceptions::NotAuthorizedError
    end
  end
  
  def user_not_authorized exception
    flash[:alert] = "You are not authorized to do that."
    redirect_to(request.referrer || root_path)
  end
end
