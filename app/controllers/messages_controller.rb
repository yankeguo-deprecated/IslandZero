class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    post_params = params.require(:message).permit(:chattable_id, :chattable_type, :content)
    if post_params[:content].blank?
      flash.alert = t(:content_missing)
      redirect_to :back
      return
    end
    current_user.messages.create(post_params)
    redirect_to :back
  end

end
