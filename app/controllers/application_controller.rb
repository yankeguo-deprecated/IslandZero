class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_locale

  def authenticate_admin!
    unless current_user.is_admin
      flash.alert = t(:you_are_not_admin)
      redirect_back
    end
  end

  def authenticate_super_admin!
    unless current_user.is_super_admin
      flash.alert = t(:you_are_not_super_admin)
      redirect_back
    end
  end

  def redirect_back(options = {}, response_status = {})
    if request.env["HTTP_REFERER"].present?
      redirect_to :back
    else
      if options.present?
        redirect_to options, response_status
      else
        redirect_to root_path
      end
    end
  end

  def redirect_js(options)
    render js: "Turbolinks.visit('#{url_for(options)}')"
  end

  private

  def set_locale
    I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
  end

end
