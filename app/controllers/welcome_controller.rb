class WelcomeController < ApplicationController
  before_action :authenticate_user!, only: [:timeline]

  def index
    if user_signed_in?
      if current_user.events.count == 0
        redirect_to topics_path
      else
        redirect_to timeline_path
      end
    else
      if IslandZero.open_to_public
        redirect_to topics_path
      end
    end
  end

  def timeline
    @events = current_user.events.order("id DESC").paginate(page: params[:page])
  end

end
