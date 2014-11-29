class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    post_params = params.require(:message)
    .permit(:chattable_id, :chattable_type, :content)
    .clean(:content)

    if post_params[:content].blank?
      if request.xhr?
        render plain: t(:content_missing), status: 400
      else
        flash.alert = t(:content_missing)
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
