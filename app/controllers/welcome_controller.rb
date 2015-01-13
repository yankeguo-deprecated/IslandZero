class WelcomeController < ApplicationController
  before_action :authenticate_user!, only: [:timeline]

  def index
    if user_signed_in?
      redirect_to timeline_path
    end
  end

  def timeline
    @events = current_user.events.order("id DESC").paginate(page: params[:page])
  end

end
