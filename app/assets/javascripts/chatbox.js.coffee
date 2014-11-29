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
Chatbox.setupFormSend = (form)->
  inputEle = form.find '#input-content'
  form.on 'ajax:beforeSend', ->
    inputEle.attr('disabled', true)
  form.on 'ajax:success', (data, status, xhr)->
    inputEle.val("")
  form.on 'ajax:error', (event, xhr, error)->
    alert xhr.responseText
  form.on 'ajax:complete', ->
    inputEle.attr('disabled', false)


@Chatbox = Chatbox
