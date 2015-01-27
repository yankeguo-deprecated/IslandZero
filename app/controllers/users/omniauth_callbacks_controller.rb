class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def twitter
    @user = User.find_for_oauth(:twitter, omniauth_auth, current_user)
    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Twitter"
    sign_in_and_redirect @user, :event => :authentication
  end

  def google_oauth2
    @user = User.find_for_oauth(:google_oauth2, omniauth_auth, current_user)
    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
    sign_in_and_redirect @user, :event => :authentication
  end

  def github
    @user = User.find_for_oauth(:github, omniauth_auth, current_user)
    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Github"
    sign_in_and_redirect @user, :event => :authentication
  end

  private

  def omniauth_auth
    request.env["omniauth.auth"]
  end

end
