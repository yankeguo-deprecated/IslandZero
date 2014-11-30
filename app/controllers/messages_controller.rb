class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    post_params = params.require(:message)
    .permit(:chattable_id, :chattable_type, :content)
    .clean(:content)

    # Check and return error
    if post_params[:content].blank?
      if request.xhr?
        render plain: t(:content_missing), status: 400
      else
        flash.alert = t(:content_missing)
        redirect_to :back
      end
      return
    end

    # Create model
    @message = current_user.messages.create(post_params)

    # Push to channel
    RealtimeChatController.publish "/chat/#{@message.chattable_type}/#{@message.chattable_id}", {
      user_id:        @message.user.id,
      user_nickname:  @message.user.nickname,
      content:        @message.content,
      created_at:     @message.created_at,
      _html:          render_to_string(partial: 'shared/chatitem', locals: { msg: @message })
    }

    # Render
    if request.xhr?
      render nothing: true
    else
      redirect_to :back
    end
  end

end
