class Chatbox
  constructor: (@element, channelName)->
    # Ensure single Chatbox
    if Chatbox.current
      Chatbox.current.cancel()
    Chatbox.current = this
    @subscribe channelName
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
    @element.prepend msg._html

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

$(document).on 'page:change', ()->
  channel = $("meta[name='chatroom-channel']").attr "content"
  if channel? and channel != ""
    Chatbox.setupFormSend $("#chatroom-send-form")
    new Chatbox $("#chatroom-content"), channel


@Chatbox = Chatbox
