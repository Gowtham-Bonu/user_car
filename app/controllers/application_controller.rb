class ApplicationController < ActionController::Base
  before_action :require_login?
  rescue_from ActiveRecord::RecordNotFound, with: :send_message

  def logged_in?
    session[:current_user_id]
  end
  
  def require_login?
    if !logged_in?
      flash[:error] = "you must be logged in to perform this action"
      redirect_to new_login_path
    end
  end

  def current_user
    @_current_user ||= session[:current_user_id] && User.find_by(id: session[:current_user_id])
  end

  private

  def send_message
    render plain: "Record is not found"
  end
end
  