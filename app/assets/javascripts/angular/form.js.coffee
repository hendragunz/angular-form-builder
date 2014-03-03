@FormBuilderCtrl = ["$scope", "$timeout", ($scope, $timeout) ->
  $scope.form
  $scope.fields
  $scope.field_types

  $scope.sortableOptions =
    update: (e, ui) ->
      $timeout (->
        angular.forEach $scope.fields, (field, index) ->
          field.position = index
          console.log field
      ), 100
    axis: 'y'

  # method to add more field
  $scope.addField = (field_type) ->
    field = {
      persisted: false
      deleted: false
      id: $scope.unique_id()
      name: 'field_' + $scope.unique_id()
      field_label: 'Field Label'
      field_hint: ''
      field_type: field_type
      required: false
      position: ($scope.fields.length + 1)
      properties: {}
      field_options: []
    }

    # prepopulate field options if field type is mcq | dropdown
    if (field.field_type == 'mcq') || (field.field_type == 'dropdown') || (field.field_type == 'rating') || (field.field_type == 'checkbox')
      field.field_options = [
        {name: 'Option 1', id: $scope.unique_id() + 1, persisted: false, deleted: false}
        {name: 'Option 2', id: $scope.unique_id() + 2, persisted: false, deleted: false}
        {name: 'Option 3', id: $scope.unique_id() + 3, persisted: false, deleted: false}
      ]

    # prepopulate field options if field type is boolean
    if (field.field_type == 'boolean')
      field.properties =
        true_label: 'Yes'
        false_label: 'No'

    $scope.fields.push( field )

  # method to remove field
  $scope.removeField = (field) ->
    if field.persisted
      if confirm( I18n.t('form').confirm_remove_field )
        field.deleted = true
    else
      $scope.fields.splice( $scope.fields.indexOf(field), 1 )

  $scope.addFieldOption = (field) ->
    field.field_options.push({name: 'New option', id: $scope.unique_id(), persisted: false, deleted: false})

  $scope.removeFieldOption = (field, field_option)->
    if field_option.persisted
      if confirm( I18n.t('form').confirm_remove_field )
        field_option.deleted = true
    else
      field.field_options.splice( field.field_options.indexOf(field_option), 1 )

  # will return unique_id
  $scope.unique_id = () ->
    (new Date()).getTime()

  # toggle show / hide form field configuration
  $scope.toggleFieldConfig = (field) ->
    $container = $('#form-field-' + field.id)
    $field_container = $container.find('.field-config-container')
    $field_container.toggleClass('hide')
    return false

  # display field options based on field type
  $scope.needField = (field, field_needed) ->
    field_type = $scope.field_types[field.field_type]
    return ( field_type.options.indexOf(field_needed) >= 0 )


  angular.element(document).ready () ->
    $timeout (->
      $scope.form.introduction ||= I18n.t('form').content_should_go_in_text_area
      console.log $scope.fields
      console.log "---------------------------"
      console.log $scope.form
      console.log "---------------------------"
      console.log $scope.field_types
    )

]

@FormStyleCtrl = ["$scope", ($scope, $http) ->
  # $http.get("/default_form_templates.json"
  # ).success( (data) ->
  #   $scope.themes = data.themes
  # ).error (status) ->
  #   alert "An error occured"
]