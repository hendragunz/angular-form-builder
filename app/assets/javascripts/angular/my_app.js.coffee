bootstrapAngular = ->
  angular.module('FormBuilder', ['ui.sortable', 'imageupload']).directive('onLastRepeat', () ->
    return (scope, element, attrs) ->
      if (scope.$last)
        setTimeout( ->
          initFormBuilderDateTimePicker()
          Holder.run()
        , 1)
  ).directive('stopEvent', ->
    return {
      restrict: 'A',
      link: (scope, element, attr) ->
        element.bind(attr.stopEvent, (e) ->
          e.stopPropagation()
        )
    }

  )
  angular.bootstrap(document.body, ['FormBuilder'])

$(document).on('ready page:load', bootstrapAngular)