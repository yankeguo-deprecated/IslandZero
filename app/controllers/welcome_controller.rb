class WelcomeController < ApplicationController

  def index
    if user_signed_in?
      redirect_to topics_path
    end
  end

end
