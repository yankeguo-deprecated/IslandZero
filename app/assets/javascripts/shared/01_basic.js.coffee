# Enable progress bar
Turbolinks.enableProgressBar()

$(document).on 'page:change', ()->
  # Bind form with page reloads
  $("form.need-reload").on 'ajax:success', (data, status, xhr)->
    Turbolinks.visit()
  $("a.need-reload").on 'ajax:success', (data, status, xhr)->
    Turbolinks.visit()
