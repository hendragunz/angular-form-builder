json.array!(@evaluations) do |evaluation|
  json.extract! evaluation, :id, :date, :procedure_id, :evaluation_form_id, :evaluator_id, :resident_id
  json.url evaluation_url(evaluation, format: :json)
end
