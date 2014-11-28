class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    post_params = params.require(:message).permit(:chattable_id, :chattable_type, :content)
    if post_params[:content].blank?
      flash.alert = t(:content_missing)
      if request.xhr?
        render nothing: true
      else
        redirect_to :back
      end
      return
    end
    current_user.messages.create(post_params)

    if request.xhr?
      render nothing: true
    else
      redirect_to :back
    end
  end

end
