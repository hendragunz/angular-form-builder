window.Util ||= {}

Util.onReady = ()->
  $("[data-toggle=offcanvas]").click ->
    $(".row-offcanvas").toggleClass "active"

  $(".is-clickable").click ->
    Turbolinks.visit($(this).data('url'))

  $("select[id$='field_type']").change ->
  return


Util.initDateTimePicker = ()->
  # $("form").find(".datepicker").datetimepicker
  #   pickTime: false

  # $("form").find(".datetimepicker").datetimepicker()