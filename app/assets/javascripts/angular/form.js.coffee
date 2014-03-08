@FormBuilderCtrl = ["$scope", "$timeout", ($scope, $timeout) ->
  $scope.form
  $scope.fields
  $scope.field_types

  $scope.sortableOptions =
    update: (e, ui) ->
      $timeout (->
        angular.forEach $scope.fields, (field, index) ->
          field.position = index
      ), 100
    axis: 'y'

  # create range array number with min & max & step
  $scope.range = (min, max, step) ->
    step  = ((step == undefined) ? 1 : step)
    input = []
    i = min
    while i <= max
      input.push(i)
      i = i+step
    return input

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

    switch field.field_type
      # prepopulate field options if field type is mcq | dropdown
      when 'mcq', 'dropdown', 'checkbox'
        field.field_options = [
          {name: 'Option 1', id: $scope.unique_id() + 1, persisted: false, deleted: false}
          {name: 'Option 2', id: $scope.unique_id() + 2, persisted: false, deleted: false}
          {name: 'Option 3', id: $scope.unique_id() + 3, persisted: false, deleted: false}
        ]

      when 'rating'
        field.field_label = 'Rating'
        field.properties =
          symbol: 'number'
          max_rating: 5
          format: 'inline'

      when 'phone'
        field.field_label = 'Phone'

      when 'price'
        field.field_label = 'Price'
        field.properties =
          currency: '$'
          add_on: 'prepend'

      when 'range'
        field.field_label = 'Range'
        field.properties =
          from_number: 0
          to_number: 0

      when 'boolean'
        field.properties =
          true_label: 'Yes'
          false_label: 'No'

      when 'facebook'
        field.field_label = 'Facebook'
        field.field_hint =  'Enter valid facebook page URL'

      when 'section'
        field.properties = {
          description: "Section detail here..."
        }

      when 'twitter'
        field.field_label = 'Twitter'
        field.field_hint  = 'Enter twitter username'

      when 'website'
        field.field_label = 'URL'
    # end of switch

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
      angular.forEach $scope.fields, (field, index) ->
        if field.field_type == 'rating'
          field.properties.max_rating = parseInt(field.properties.max_rating)

      # console.log $scope.fields
      # console.log "---------------------------"
      # console.log $scope.form
      # console.log "---------------------------"
      # console.log $scope.field_types
    )

]

@FormStyleCtrl = ["$scope", ($scope, $http) ->
  # $http.get("/default_form_templates.json"
  # ).success( (data) ->
  #   $scope.themes = data.themes
  # ).error (status) ->
  #   alert "An error occured"
]