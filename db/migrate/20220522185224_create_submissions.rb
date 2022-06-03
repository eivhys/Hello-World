# frozen_string_literal: true

class CreateSubmissions < ActiveRecord::Migration[7.0]
  def change
    create_table(:submissions, id: :uuid) do |t|
      t.string(:implementation)
      t.references(:user, null: false, foreign_key: true, type: :uuid)
      t.references(:exercise, null: false, foreign_key: true, type: :uuid)
      t.float(:score, default: 0.0)
      t.boolean(:passed, default: false)

      t.timestamps
    end
  end
end
