bootstrapAngular = ->
  angular.module('FormBuilder', ['ui.sortable']);
  angular.bootstrap(document.body, ['FormBuilder'])

$(document).on('ready page:load', bootstrapAngular)