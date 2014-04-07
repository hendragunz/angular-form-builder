module FieldTypeCollection
  extend ActiveSupport::Concern

  FieldConfig = {
    address:        {type: 'text',      options: ['label', 'hint', 'required']},
    percentage:     {type: 'number',    options: ['label', 'hint', 'required', 'range']},
    boolean:        {type: 'radio',     options: ['label', 'hint', 'required', 'boolean_label']},
    checkbox:       {type: 'checkbox',  options: ['label', 'hint', 'required', 'field_options']},
    date:           {type: 'date',      options: ['label', 'hint', 'required']},
    datetime:       {type: 'datetime',  options: ['label', 'hint', 'required']},
    dropdown:       {type: 'select',    options: ['label', 'hint', 'required', 'field_options']},
    email:          {type: 'email',     options: ['label', 'hint', 'required']},
    facebook:       {type: 'text',      options: ['label', 'hint', 'required']},
    file:           {type: 'file',      options: ['label', 'hint', 'required']},
    mcq:            {type: 'radio',     options: ['label', 'hint', 'required', 'field_options']},
    radio:          {type: 'radio',     options: ['label', 'hint', 'required', 'field_options']},
    number:         {type: 'number',    options: ['label', 'hint', 'required', 'range']},
    paragraph:      {type: 'textarea',  options: ['label', 'hint', 'required']},
    phone:          {type: 'tel',       options: ['label', 'hint', 'required']},
    picture_choice: {type: 'radio',     options: ['label', 'hint', 'required', 'picture_options']},
    price:          {type: 'number',    options: ['label', 'hint', 'required', 'currency']},
    question_group: {type: 'text',      options: ['label', 'hint', 'required', 'groups']},
    range:          {type: 'number',    options: ['label', 'hint', 'required', 'range']},
    rating:         {type: 'radio',     options: ['label', 'hint', 'required', 'rating']},
    section:        {type: 'section',   options: ['label', 'description']},
    single_line:    {type: 'text',      options: ['label', 'hint', 'required']},
    statement:      {type: 'rowcolumn', options: ['label', 'hint', 'required', 'statements']},
    time:           {type: 'time',      options: ['label', 'hint', 'required']},
    twitter:        {type: 'text',      options: ['label', 'hint', 'required']},
    website:        {type: 'url',       options: ['label', 'hint', 'required']}
  }

  included do
    extend Enumerize
    enumerize :field_type, in: Enum::FormField::FIELD_TYPE[:options],
                           default: Enum::FormField::FIELD_TYPE[:default],
                           predicates: { prefix: true }
  end
end
