Jbuilder.encode do |json|
  #json.content format_content(@message.content)
  json.(@form, :created_at, :updated_at)


  json.fields @form.fields, :field_type, :created_at

  #json.attachments @message.attachments do |attachment|
  #  json.filename attachment.filename
  #  json.url url_for(attachment)
  #end
end