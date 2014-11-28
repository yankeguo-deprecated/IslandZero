class Chatbox
  constructor: (@element)->
    # Ensure single Chatbox
    if Chatbox.current
      Chatbox.current.cancel()
    Chatbox.current = this
  subscribe: (room)=>
    return unless room? and room != ""
    @cancel()
    Pusher.init()
    @channel = Pusher.client.subscribe room, @onMessage
  cancel: ()=>
    if @channel?
      @channel.cancel()
      @channel = null
  onMessage: (msg)=>
    @element.prepend "
    <p class=\"text-primary\">
      <small class=\"text-muted\">
        #{msg.user_nickname} (##{msg.user_id})
        <span class=\"pull-right\">#{msg.created_at}</span>
      </small>
      <br/>
      #{msg.content}
    </p>
    "

@Chatbox = Chatbox
