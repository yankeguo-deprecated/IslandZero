class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :check_duplicated_email, only: [:google_oauth2, :github]

  def twitter
    @user = User.find_for_twitter_oauth2(omniauth_auth)
    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Twitter"
    sign_in_and_redirect @user, :event => :authentication
  end

  def google_oauth2
    @user = User.find_for_google_oauth2(omniauth_auth)
    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
    sign_in_and_redirect @user, :event => :authentication
  end

  def github
    @user = User.find_for_github_oauth2(omniauth_auth)
    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Github"
    sign_in_and_redirect @user, :event => :authentication
  end

  private

  def omniauth_auth
    request.env["omniauth.auth"]
  end

  def check_duplicated_email
    if User.find_by(email: omniauth_auth.info["email"]).present?
      flash[:alert] = I18n.t "duplicated_email"
      redirect_to new_user_session
    end
  end

end
