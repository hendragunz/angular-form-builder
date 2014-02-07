class Option < ActiveRecord::Base

  # ASSOCIATIONS
  # ------------------------------------------------------------------------------------------------------
  belongs_to :question, class_name: "EvaluationFormQuestion", foreign_key: "evaluation_form_question_id"
end
