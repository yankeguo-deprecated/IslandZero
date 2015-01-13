module WelcomeHelper

  def user_or_me(user)
    return "" if user.nil?
    if user.id == current_user.id
      t(:you)
    else
      "#{user.nickname}(#{user.id})"
    end
  end

end
