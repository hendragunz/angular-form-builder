bootstrapAngular = ->
  angular.module('FormBuilder', ['ui.sortable']).directive('onLastRepeat', () ->
    return (scope, element, attrs) ->
      if (scope.$last)
        setTimeout( ->
          initFormBuilderDateTimePicker()
        , 1)
  )
  angular.bootstrap(document.body, ['FormBuilder'])

$(document).on('ready page:load', bootstrapAngular)