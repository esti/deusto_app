class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def login_required
    unless current_user
      notice = "You need to be logged in in order to tweet"
      respond_to do |format|
        format.html do
          redirect_to login_path, :notice => notice
        end
        format.js do
          render :update do |page|
            page.alert notice
          end
        end
      end
    end
  end
  
end
