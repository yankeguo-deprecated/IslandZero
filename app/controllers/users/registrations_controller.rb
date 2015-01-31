class Users::RegistrationsController < Devise::RegistrationsController
  # before_filter :configure_sign_up_params, only: [:create]
  before_filter :configure_account_update_params, only: [:update]
  prepend_before_filter :authenticate_scope!, only: [:edit, :update, :destroy, :revoke_oauth]


  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  def edit
    super

    if resource.try(:is_email_fake)
      resource.email = ''
    end
  end

  # PUT /resource
  #def update
  #  super
  #end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # POST /resource/revoke_oauth?provider=[provider]
  # Revoke the oauth from user
  def revoke_oauth
    provider = params[:provider].to_s.to_sym
    if resource.oauth_count == 1 and resource.is_email_fake
      flash.alert = t(:cannot_revoke_oauth_while_email_is_fake)
    else
      if resource_class.omniauth_providers.include?(provider) and resource.has_oauth?(provider)
        resource.revoke_oauth provider
      end
    end
    render nothing: true
  end

  protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # You can put the params you want to permit in the empty array.
  def configure_account_update_params
    devise_parameter_sanitizer.for(:account_update) << :nickname
  end

  def update_resource(resource, params)
    if params[:current_password].blank?
      if resource.try(:is_email_fake) and params[:email].present?
        resource.update_without_password(params.permit(:nickname, :email))
      else
        resource.update_without_password(params.permit(:nickname))
      end
    else
      super
    end
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
