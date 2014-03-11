window.Util ||= {}

# Initialize Date Time Picker / Date picker
Util.initDateTimePicker = ()->
  $(".datepicker").datetimepicker
    pickTime: false
  $(".datetimepicker").datetimepicker()


# Document Ready should be here
Util.onReady = ()->
  $("[data-toggle=offcanvas]").click ->
    $(".row-offcanvas").toggleClass "active"

  $(".is-clickable").click ->
    Turbolinks.visit($(this).data('url'))

  $("select[id$='field_type']").change ->
    return

  Util.initDateTimePicker()



# Calling document ready
$(document).on('ready page:load', Util.onReady)