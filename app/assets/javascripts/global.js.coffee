window.Util ||= {}

# Initialize Date Time Picker / Date picker
Util.initDateTimePicker = ()->
  $(".datepicker").datetimepicker
    pickTime: false

  $(".datetimepicker").datetimepicker
    minuteStepping: 15
    useSeconds: false


# Document Ready should be here
Util.onReady = ()->
  $("[data-toggle=offcanvas]").click ->
    $(".row-offcanvas").toggleClass "active"

  $(".is-clickable").click ->
    Turbolinks.visit($(this).data('url'))

  $("select[id$='field_type']").change ->
    return

  Util.initDateTimePicker()

  $('.new_form_entry').on 'click', '.img-thumbnail', ()->
    $(this).closest('.input-group').find('.img-thumbnail').removeClass('active')
    $(this).addClass('active')



# Calling document ready
$(document).on('ready page:load', Util.onReady)