bootstrapAngular = ->
  angular.module('FormBuilder', ['ui.sortable']).directive('onLastRepeat', () ->
    return (scope, element, attrs) ->
      if (scope.$last)
        setTimeout( ->
          initFormBuilderDateTimePicker()
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