# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@ChatHelper =
  createPublicChatbox: (form, list)=>
    # Set Nickname from Cookie
    nickname = document.cookie.replace /(?:(?:^|.*;\s*)public_chat_nickname\s*\=\s*([^;]*).*$)|^.*$/, "$1"
    form.children("#chat-input-nickname").val(nickname)
    # Rebind channel
    if @channelChat?
      @channelChat.cancel()
      @cnannelChat = null
    # Subscribe
    @channelChat = @faye.subscribe '/chat/public', (msg)->
      list.prepend "<li class=\"list-group-item\">#{msg.nickname} : #{msg.content}</li>"
    # Publish
    form.submit (e)=>
      e.preventDefault()
      # Build Params
      paramObj = {}
      $.each form.serializeArray(), (_, kv) ->
        paramObj[kv.name] = kv.value
      # Remember Nickname
      date = new Date()
      date.setTime date.getTime()+3600*1000*24*100
      document.cookie = "public_chat_nickname=#{escape paramObj['nickname']}; expires=#{ date.toGMTString() }"
      # Send
      @faye.publish '/chat/public', paramObj
      # Clear
      form.children("#chat-input-content").val("").focus()
