class ChatController < ApplicationController

  def public
    @public_msgs = PublicMsg.all.order("id DESC").first(100)
  end

end
