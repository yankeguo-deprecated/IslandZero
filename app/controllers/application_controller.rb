class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_locale

  def authenticate_admin!
    unless current_user.is_admin
      flash.alert = t(:you_are_not_admin)
      redirect_to :back
    end
  end

  private

  def set_locale
    I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
  end

end
