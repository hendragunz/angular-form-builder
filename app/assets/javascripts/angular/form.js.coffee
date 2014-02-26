@FormBuilderCtrl = ["$scope", ($scope) ->
  $scope.fields
  $scope.field_types = {
    mcq:          'mcq'
    paragraph:    'paragraph'
    single_line:  'single_line'
    rating:       'rating'
    boolean:      'boolean'
    price:        'price'
    dropdown:     'dropdown'
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
        # {name: 'Option 1', id: $scope.unique_id(), persisted: false}
      ]
    }

    # prepopulate field options if field type is mcq | dropdown
    if (field.field_type == 'mcq') || (field.field_type == 'dropdown')
      field.field_options = [
        {name: 'Option 1', id: $scope.unique_id() + 1, persisted: false, deleted: false}
        {name: 'Option 2', id: $scope.unique_id() + 2, persisted: false, deleted: false}
        {name: 'Option 3', id: $scope.unique_id() + 3, persisted: false, deleted: false}
      ]

    $scope.fields.push( field )

  # method to remove field
  $scope.removeField = (field) ->
    if field.persisted
      field.deleted = true
    else
      $scope.fields.splice( $scope.fields.indexOf(field), 1 );

  $scope.addFieldOption = (field) ->
    field.field_options.push({name: 'New Option', id: $scope.unique_id(), persisted: false, deleted: false})

  $scope.removeFieldOption = (field, field_option)->
    console.log field_option
    if field_option.persisted
      field_option.deleted = true
    else
      field.field_options.splice( field.field_options.indexOf(field_option), 1 )
    console.log field_option

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