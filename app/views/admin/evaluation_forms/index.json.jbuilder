json.array!(@evaluation_forms) do |evaluation_form|
  json.extract! evaluation_form, :id
  json.url admin_evaluation_form_url(evaluation_form, format: :json)
end
