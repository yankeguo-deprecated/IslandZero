# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
updateNewSubPostButton = ()->
  if isBlank($("#newSubPostInputContent").val())
    $("#newSubPostSubmit").attr 'disabled', 'disabled'
  else
    $("#newSubPostSubmit").removeAttr 'disabled'

$(document).on 'page:change', ()->
  updateNewSubPostButton()
  $("#newSubPostInputContent").keyup updateNewSubPostButton
  $("a.reply-link").click (e)->
    e.preventDefault()
    $("#collapseNewPost").collapse("show")
    $("#newSubPostInputContent").append("@#{$(this).attr("data-user-nickname")}(#{$(this).attr("data-user-id")})\n").focus()
