# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@ChatHelper =
  createPublicChatbox: (form, list)=>
    inputNickname = form.children("#chat-input-nickname")
    inputContent  = form.children("#chat-input-content")
    # Set Nickname from Cookie
    nickname = document.cookie.replace(/(?:(?:^|.*;\s*)public_chat_nickname\s*\=\s*([^;]*).*$)|^.*$/, "$1") || ""
    nickname = unescape(nickname)
    if nickname.length == 0
      inputNickname.focus()
    else
      inputContent.focus()
    inputNickname.val(nickname)
    # Rebind channel
    if @channelChat?
      @channelChat.cancel()
      @cnannelChat = null
    # Subscribe
    @channelChat = @faye.subscribe '/chat/public', (msg)->
      list.prepend "<li class=\"list-group-item\"><span class=\"text-chat-nickname\">#{msg.nickname}</span> : <span class=\"text-chat-content\">#{msg.content}</span></li>"
    # Publish
    form.submit (e)=>
      e.preventDefault()
      # Remember Nickname
      date = new Date()
      date.setTime date.getTime()+3600*1000*24*100
      document.cookie = "public_chat_nickname=#{inputNickname.val()}; expires=#{ date.toGMTString() }"
      # Send
      @faye.publish '/chat/public', {nickname: inputNickname.val(), content: inputContent.val()}
      # Clear
      inputContent.val("").focus()
