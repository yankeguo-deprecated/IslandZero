class Users::PasswordsController < Devise::PasswordsController
  def update
    super

    #for fake password users, update fake password to false
    if resource.errors.empty? and resource.try(:is_password_fake)
      resource.update(is_password_fake: false)
    end
  end
end
