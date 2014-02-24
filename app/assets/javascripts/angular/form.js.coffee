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
    console.log 'run!!!'
    field = {
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
    }
    $scope.fields.push( field )

  # will return unique_id
  $scope.unique_id = ()->
    (new Date()).getTime()

]