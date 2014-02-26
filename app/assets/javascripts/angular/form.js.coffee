@FormBuilderCtrl = ["$scope", ($scope) ->
  $scope.fields
  $scope.field_types = {
    mcq:          'mcq'
    paragraph:    'paragraph'
    single_line:  'single_line'
    rating:       'rating'
    boolean:      'boolean'
  }

  # method to add more field
  $scope.addField = (field_type) ->
    field = {
      persisted: false
      deleted: false
      id: $scope.unique_id()
      name: 'field_' + $scope.unique_id()
      en_label: 'Field Label'
      en_hint: ''
      field_type: field_type
      required: false
      position: ($scope.fields.length + 1)
      properties: {
        true_label: ''
        false_label: ''
      }
      field_options: [
        # {name: 'Option 1', id: $scope.unique_id()}
      ]
    }
    $scope.fields.push( field )

  # method to remove field
  $scope.removeField = (field) ->
    $scope.fields.splice( $scope.fields.indexOf(field), 1 );

  $scope.addFieldOption = (field) ->
    field.field_options.push({name: 'New Option', id: $scope.unique_id(), persisted: false})

  $scope.removeFieldOption = (field, field_option)->
    field.field_options.splice( field.field_options.indexOf(field_option), 1 )

  # will return unique_id
  $scope.unique_id = () ->
    (new Date()).getTime()

  # toggle show / hide form field configuration
  $scope.toggleFieldConfig = (field) ->
    $container = $('#form-field-' + field.id)
    $field_container = $container.find('.field-config-container')
    console.log $field_container
    $field_container.toggleClass('hide')
    return false

  angular.element(document).ready () ->
    console.log $scope.fields

]