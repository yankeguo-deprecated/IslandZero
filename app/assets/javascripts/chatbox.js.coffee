class Chatbox
  constructor: (@element)->
    # Ensure single Chatbox
    if Chatbox.current
      Chatbox.current.cancel()
    Chatbox.current = this
  subscribe: (room = Chatbox.getPageRoom())=>
    return unless room? and room != ""
    @cancel()
    Pusher.init()
    @channelName = "/chat/#{room}"
    @channel = Pusher.client.subscribe @channelName, @onMessage
  cancel: ()=>
    if @channel?
      @channel.cancel()
      @channelName = null
      @channel = null
  onMessage: (msg)=>
    #TODO: better message listing
    @element.innerHTML += msg

Chatbox.getPageRoom = ()->
  $("meta[name='chatbox-room']").attr("content")

Chatbox.sendMessage = (content = "", room = Chatbox.getPageRoom())=>
  return unless room? and room != ""
  if content.length == 0
    alert "Content cannot be empty."
  else
    $.post "/messages", { content, room }

@Chatbox = Chatbox
