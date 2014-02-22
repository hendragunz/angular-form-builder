ready = ->
  $("select[id$='field_type']").change ->
    $("[id$='-fields']").css("display","none");
    if (this.value == "mcq")
      $("#mcq-fields").css("display","block");
    else if (this.value == "rating")
      $("#rating-fields").css("display","block");
    else if(this.value == "boolean")
      $("#boolean-fields").css("display","block");

#    $.ajax(
#      type: "GET"
#      url: "/type"
#      data:
#        type: this.value
#    ).done (partial) ->
#      $("#field-render-area").html(partial)

$(document).ready(ready)
$(document).on('page:load', ready)