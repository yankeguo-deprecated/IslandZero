# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@ChatHelper =
  createPublicChatbox: (form, list)=>
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
      # Send
      @faye.publish '/chat/public', paramObj
      # Clear
      form.children("#chat-input-content").val("").focus()
