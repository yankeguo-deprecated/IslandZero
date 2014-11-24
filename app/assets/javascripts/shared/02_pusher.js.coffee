# faye.js should be ported before application.js in layout, so we got Faye.Client here
Pusher =
  init: ()=>
    return if Pusher.client?
    # Create client
    Pusher.client = new Faye.Client '/faye'

@Pusher = Pusher
