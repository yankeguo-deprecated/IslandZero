class Chatbox
  constructor: (@element)->
  subscribe: (room = Chatbox.getPageRoom())=>
    return unless room?
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

@Chatbox = Chatbox
