@FormBuilderCtrl = ["$scope", ($scope) ->
  $scope.fields
  $scope.field_types = {
    msq:          'msq'
    paragraph:    'text'
    single_line:  'single_line'
    rating:       'rating'
    boolean:      'boolean'
  }

  # method to add more field
  $scope.addField = (field_type)->
    field = {
      persisted: false
      id: $scope.unique_id()
      name: 'name_' + $scope.unique_id()
      en_label: 'name-x'
      en_hint: ''
      field_type: field_type
      required: false
      position: 0
      properties: {
        true_label: 'Yes'
        false_label: 'No'
      }
      field_options: [
        {name: 'Option 1'}
        {name: 'Option 2'}
        {name: 'Option 3'}
      ]
    }
    $scope.fields.push( field )

  # will return unique_id
  $scope.unique_id = ()->
    (new Date()).getTime()

  angular.element(document).ready ()->
    console.log $scope.fields

]