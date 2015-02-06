@Notifier = Notifier = {}

Notifier.loadCount = ()->
  Notifier.count = parseInt $.cookie "unread-events-count"
  if !Notifier.count
    Notifier.count = 0

Notifier.saveCount = ()->
  $.cookie "unread-events-count", "#{Notifier.count}", { expires: 7 }

Notifier.rebind = ()->
  Notifier.count = 0 unless Notifier.count?
  Notifier.saveCount()
  Pusher.init()
  userId = parseInt($("meta[name='current-user-id']").attr("content"))
  if !userId
    Notifier.userId = null
    if Notifier.channel?
      Notifier.channel.cancel()
      Notifier.channel = null
    else
  else
    if userId != Notifier.userId
      Notifier.userId = userId
      if Notifier.channel?
        Notifier.channel.cancel()
      Notifier.channel = Pusher.client.subscribe "/users/#{userId}/events", (message)->
        Notifier.count += 1
        Notifier.saveCount()
        Notifier.updateBadge()
  Notifier.updateBadge()

Notifier.updateBadge = ()->
  if Notifier.count != 0
    $("#events-badge").show()
    $("#events-badge").text("#{Notifier.count}")
  else
    $("#events-badge").hide()

$(document).on 'page:change', ()->
  if $("meta[name='timeline-page']").attr("content") == 'true'
    Notifier.count = 0
    Notifier.saveCount()
  Notifier.rebind()

# Load count once
$(document).on 'ready', ()->
  Notifier.loadCount()

