# frozen_string_literal: true

class CreateLevels < ActiveRecord::Migration[7.0]
  def change
    create_table(:levels, id: :uuid) do |t|
      t.string(:title, null: false)
      t.references(:challenge, null: false, foreign_key: true, type: :uuid)
      t.integer(:position, null: false)

      t.timestamps
    end
  end
end
