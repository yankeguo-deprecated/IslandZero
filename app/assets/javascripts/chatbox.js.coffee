class Chatbox
  constructor: (elem)->
    Chatbox.shared.cancel() if Chatbox.shared?
    Chatbox.shared = this
    @form = elem.find "form[chatbox-form]"
    @input= elem.find "input[chatbox-input]"
    @list = elem.find "div[chatbox-list]"
    @form.submit @onSubmit
  subscribe: (room)=>
    return if @channel?
    Pusher.init()
    @channelName = "/chat/#{room}"
    @channel = Pusher.client.subscribe @channelName, @onMessage
  cancel: ()=>
    if @channel?
      @channel.cancel()
      @channel = null
  # Events
  onMessage: (msg)=>
    #TODO: better message listing
    @list.append msg
  onSubmit: (e)=>
    # Disable form submit
    e.preventDefault()
    # Check channel
    return unless @channel?
    # Check message
    content = @input.val() || ""
    if content.length == 0
      # Set placeholder for error
      @input.attr "placeholder", "Content should not be empty"
    else
      # Clear placeholder
      @input.attr "placeholder", ""
      Pusher.client.publish @channelName, { content: content }

@Chatbox = Chatbox
