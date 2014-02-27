Util.onReady ->
	$("[data-toggle=offcanvas]").click ->
    $(".row-offcanvas").toggleClass "active"

  $("form.simple_form input[type='text'], form.simple_form input[type='number'], form.simple_form input[type='email'], form.simple_form input[type='password'], form.simple_form input[type='tel'], form.simple_form input[type='url'], form.simple_form select, form.simple_form textarea").addClass "form-control"

  $(".is-clickable").click ->
    Turbolinks.visit($(this).data('url'))

  $("select[id$='field_type']").change ->
  return