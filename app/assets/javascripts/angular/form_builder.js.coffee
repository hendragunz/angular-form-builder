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


  $scope.sortableGroupOptions =
    update: (e, ui) ->
      $timeout (->
        # console.log 'yay !!'
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
      when 'address'
        field.field_label = 'Address'

      when 'boolean'
        field.properties =
          true_label: 'Yes'
          false_label: 'No'

      when 'date'
        field.field_label = 'Date'

      when 'datetime'
        field.field_label = "Date & Time"

      when 'email'
        field.field_label = 'Email'

      when 'facebook'
        field.field_label = 'Facebook'
        field.field_hint =  'Enter valid facebook page URL'

      when 'file'
        field.field_label = 'File'

      # prepopulate field options if field type is mcq | dropdown
      when 'mcq', 'dropdown', 'checkbox', 'radio'
        field.field_options = [
          {name: 'Option 1', id: $scope.unique_id() + 1, persisted: false, deleted: false}
          {name: 'Option 2', id: $scope.unique_id() + 2, persisted: false, deleted: false}
          {name: 'Option 3', id: $scope.unique_id() + 3, persisted: false, deleted: false}
        ]

      when 'number'
        field.field_label = 'Number'

      when 'percentage'
        field.field_label = 'Percentage'

      when 'picture_choice'
        field.field_label = "Picture Choice"
        field.field_options = [
          {name: 'Caption 1', id: $scope.unique_id() + 1, persisted: false, deleted: false, picture: undefined}
          {name: 'Caption 2', id: $scope.unique_id() + 2, persisted: false, deleted: false, picture: undefined}
          {name: 'Caption 3', id: $scope.unique_id() + 3, persisted: false, deleted: false, picture: undefined}
        ]

      when 'phone'
        field.field_label = 'Phone'

      when 'rating'
        field.field_label = 'Rating'
        field.properties =
          symbol: 'number'
          max_rating: 5
          # format: 'inline'

      when 'price'
        field.field_label = 'Price'
        field.properties =
          currency: '$'
          add_on: 'prepend'

      when 'question_group'
        field.field_label = 'Question Group'
        field.properties.max_rows = 1
        field.properties.groups = [
          {name: 'Column 1', add_on: 'none'}
          {name: 'Column 2', add_on: 'none'}
          {name: 'Column 3', add_on: 'none'}
        ]

      when 'range'
        field.field_label = 'Range'
        field.properties =
          from_number: 0
          to_number: 0

      when 'section'
        field.properties = {
          description: "Section detail here..."
        }

      when 'statement'
        field.field_label = 'Statement'
        field.properties.max_rows = 0
        field.properties.statements = {
          0: {name: 'Statement 1'}
          1: {name: 'Statement 2'}
          2: {name: 'Statement 3'}
        }

        field.properties.columns = {
          0: {name: 'Column 1'}
          1: {name: 'Column 2'}
          2: {name: 'Column 3'}
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
    $timeout (->
      if field.field_type == 'picture_choice'
        Holder.run()
    )

  $scope.removeFieldOption = (field, field_option) ->
    if field_option.persisted
      if confirm( I18n.t('form').confirm_remove_field )
        field_option.deleted = true
    else
      field.field_options.splice( field.field_options.indexOf(field_option), 1 )


  $scope.addFieldPropertiesStatement = (field) ->
    obj = {name: 'New statement',  persisted: false}
    idx = Object.keys(field.properties.statements).length + 1
    field.properties.statements[idx] = obj


  $scope.removeFieldPropertiesStatement = (field, statement, idx)->
    if statement.persisted
      if confirm( I18n.t('form').confirm_remove_field )
        delete field.properties.statements[idx]
    else
      delete field.properties.statements[idx]



  $scope.addFieldPropertiesColumn = (field) ->
    obj = {name: 'New Column', persisted: false}
    idx = Object.keys(field.properties.columns).length + 1
    field.properties.columns[idx] = obj


  $scope.removeFieldPropertiesColumn = (field, column, idx)->
    if column.persisted || (column.persisted == undefined)
      if confirm( I18n.t('form').confirm_remove_field )
        delete field.properties.columns[idx]
    else
      delete field.properties.columns[idx]


  $scope.checkLimitGroupQuesiton = (field)->
    if field.properties
      if field.properties.groups
        return field.properties.groups.length < 5

  $scope.removeFieldPropertiesGroup = (field, group, idx)->
    if (group.persisted == undefined) || group.persisted
      if confirm( I18n.t('form').confirm_remove_field )
        field.properties.groups.splice(idx, 1)
    else
      field.properties.groups.splice(idx, 1)



  $scope.addFieldPropertiesGroup = (field)->
    if Object.keys(field.properties.groups).length < 5
      obj = {name: 'New Column', add_on: 'none', persisted: false}
      # idx = Object.keys(field.properties.groups).length + 1
      # while field.properties.groups[idx] != undefined
      #   idx += 1
      field.properties.groups.push(obj)


  $scope.addQuestionGroupRow = (field)->
    field.properties.dummy_group_rows ||= 1
    field.properties.dummy_group_rows += 1

  $scope.removeQuestionGroupRow = (field)->
    field.properties.dummy_group_rows ||= 1
    field.properties.dummy_group_rows -= 1 if (field.properties.dummy_group_rows > 1)

  $scope.isTheLastGroupQuestion = (field)->
    !(Object.keys(field.properties.groups).length  <= 1)

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


  $scope.getGroupColumnWidthClass = (field)->
    default_class = ''
    switch  Object.keys(field.properties.groups).length
      when 1 then "col-xs-10"
      when 2 then "col-xs-5"
      when 3 then "col-xs-3"
      when 4 then "col-xs-2"
      when 5 then "col-xs-2"



  angular.element(document).ready () ->
    $timeout (->
      $('#form-container').on 'click', '.thumbnail', ()->
        $(this).closest('.row').find('.thumbnail').removeClass('active')
        $(this).addClass('active')

      $scope.form.introduction ||= I18n.t('form').content_should_go_in_text_area
      angular.forEach $scope.fields, (field, index) ->
        field.properties ||= {
          statements: []
          columns: []
        }

        switch field.field_type
          when 'rating'
            field.properties.max_rating = parseInt(field.properties.max_rating)

          when 'number', 'range', 'percentage'
            field.properties.from_number = parseInt(field.properties.from_number)
            field.properties.to_number = parseInt(field.properties.to_number)

          when 'question_group'
            field.properties.groups =  $.map(field.properties.groups, (value, index)->
              value['persisted'] = true
              value
            )


      console.log $scope.fields
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



# initialize form date picker
@initFormBuilderDateTimePicker = ->
  $("#form-container").find(".datepicker").not(".datepicker-initialized").each (idx, item) ->
    $(this).addClass "datepicker-initialized"
    $(this).datetimepicker pickTime: false

  $("#form-container").find(".datetimepicker").not(".datetimepicker-initialized").each (idx, item) ->
    $(this).addClass "datetimepicker-initialized"
    $(this).datetimepicker()

  return
