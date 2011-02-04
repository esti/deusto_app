class ApplicationController < ActionController::Base
  before_filter :set_locale

  protect_from_forgery
  
  helper_method :current_user

  private

  def set_locale
    I18n.locale = "es"
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def login_required
    unless current_user
      notice = case controller_name
        when 'users'
          "You need to be logged in in order to see the users list"
        when 'tweets'
          "You need to be logged in in order to tweet"
        else
          "You need to be logged in in order to see this page"
      end
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
