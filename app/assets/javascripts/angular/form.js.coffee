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
      en_label: 'Field Name'
      en_hint: 'Here is an example hint'
      field_type: field_type
      required: false
      position: ($scope.fields.length + 1)
      properties: {
        true_label: 'Yes'
        false_label: 'No'
      }
      field_options: [
        {name: 'Option 1', id: $scope.unique_id()}
        {name: 'Option 2', id: $scope.unique_id()}
        {name: 'Option 3', id: $scope.unique_id()}
      ]
    }
    $scope.fields.push( field )

  # method to remove field
  $scope.removeField = (field)->
    $scope.fields.splice( $scope.fields.indexOf(field), 1 );

  $scope.addFieldOption = (field)->
    field.field_options.push({name: 'New Option', id: $scope.unique_id(), persisted: false})

  $scope.removeFieldOption = (field, field_option)->
    field.field_options.splice( field.field_options.indexOf(field_option), 1 )

  # will return unique_id
  $scope.unique_id = ()->
    (new Date()).getTime()

  # toggle sho / hide form field configuration
  $scope.toggleFormFieldConfig = (field)->
    $container = $('#form-field-' + field.id)
    $field_container = $container.find('.form-field-config-container')
    console.log $field_container
    $field_container.toggleClass('hide')
    return false

  angular.element(document).ready ()->
    console.log $scope.fields

]