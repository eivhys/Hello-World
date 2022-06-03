# frozen_string_literal: true

class CreateAssessments < ActiveRecord::Migration[7.0]
  def change
    create_table(:assessments, id: :uuid) do |t|
      t.string(:input, null: false)
      t.references(:exercise, null: false, foreign_key: true, type: :uuid)
      t.integer(:leeway, null: false, default: 0)
      t.integer(:timeout, null: false, default: 10)
      t.boolean(:hidden, null: false, default: false)

      t.timestamps
    end
  end
end
