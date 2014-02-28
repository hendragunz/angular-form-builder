module FieldTypeCollection
  extend ActiveSupport::Concern

  FieldConfig = {
    single_line:  {type: 'text',      options: ['label', 'hint', 'required']},
    boolean:      {type: 'radio',     options: ['label', 'hint', 'required', 'boolean_label']},
    paragraph:    {type: 'textarea',  options: ['label', 'hint', 'required']},
    mcq:          {type: 'radio',     options: ['label', 'hint', 'required', 'field_options']},
    rating:       {type: 'radio',     options: ['label', 'hint', 'required', 'field_options']},
    number:       {type: 'number',    options: ['label', 'hint', 'required']},
    checkbox:     {type: 'checkbox',  options: ['label', 'hint']},
    dropdown:     {type: 'select',    options: ['label', 'hint', 'required', 'field_options']},
    name:         {type: 'text',      options: ['label', 'hint', 'required']},
    address:      {type: 'text',      options: ['label', 'hint', 'required']},
    date:         {type: 'date',      options: ['label', 'hint', 'required']},
    email:        {type: 'email',     options: ['label', 'hint', 'required']},
    time:         {type: 'time',      options: ['label', 'hint', 'required']},
    phone:        {type: 'tel',       options: ['label', 'hint', 'required']},
    website:      {type: 'url',       options: ['label', 'hint', 'required']},
    price:        {type: 'number',    options: ['label', 'hint', 'required']},
    likert:       {type: 'rowcolumn', options: ['label', 'hint', 'required']},
    facebook:     {type: 'text',      options: ['label', 'hint', 'required']},
    twitter:      {type: 'text',      options: ['label', 'hint', 'required']}
  }

  included do
    extend Enumerize
    enumerize :field_type,  in: Enum::FormField::FIELD_TYPE[:options],
                            default: Enum::FormField::FIELD_TYPE[:default],
                            predicates: true
  end


end



# HTML input types
# --------------------------------------------
# button
# checkbox
# color
# date
# datetime
# datetime-local
# email
# file
# hidden
# image
# month
# number
# password
# radio
# range
# reset
# search
# submit
# tel
# text
# time
# url
# week