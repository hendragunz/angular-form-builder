class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.datetime :date
      t.integer  :procedure_id
      t.string   :evaluation_form_id
      t.integer  :evaluator_id
      t.integer  :resident_id
      t.hstore   :answers

      t.timestamps
    end
  end
end
