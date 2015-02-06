# Enable progress bar
Turbolinks.enableProgressBar()

$(document).on 'page:change', ()->
  # Bind form with page reloads
  $("form.need-reload").on 'ajax:success', (data, status, xhr)->
    Turbolinks.visit()
  $("a.need-reload").on 'ajax:success', (data, status, xhr)->
    Turbolinks.visit()
  $(".with-at-support").atwho {
    at: "@"
    limit: 7
    callbacks:
      remoteFilter: (query, callback)->
        $.getJSON "/users/mention_query.json", { keyword: query }, (data) ->
          callback(data)
  }
