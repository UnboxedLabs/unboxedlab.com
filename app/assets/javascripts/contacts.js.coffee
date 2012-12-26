# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $("#ub-subscribe").bind "ajax:success", (evt, data, status, xhr) ->
    $("#subscribe").val("")

  $("#ub-subscribe").bind "ajax:error", (evt, data, status, xhr) ->
    $("#subscribe").focus()
    $("#subscribe").select()
    $(".control-group").addClass("error")

  $("#subscribe").keypress ->
    $(".control-group").removeClass("error") if $(".control-group").hasClass "error"
