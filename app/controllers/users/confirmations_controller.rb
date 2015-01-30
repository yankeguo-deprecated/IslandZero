class Users::ConfirmationsController < Devise::ConfirmationsController

  def show
    super

    # For fake email users, update is_email_fake to false 
    if resource.errors.empty? and resource.try(:is_email_fake)
      resource.update(is_email_fake: false)
      #and send update password instructions if password is fake
      if resource.try(:is_password_fake)
        flash.alert = t :reset_password_send_due_to_fake
        resource.send_reset_password_instructions
      end
    end
  end

end
