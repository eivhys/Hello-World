# frozen_string_literal: true

class CreateExercises < ActiveRecord::Migration[7.0]
  def change
    create_table :exercises, id: :uuid do |t|
      t.string :title, null: false
      t.integer :position, null: false
      t.integer :unlock_criteria, null: false, default: 0
      t.references :level, null: false, foreign_key: true, type: :uuid
      t.string :implementation, null: false

      t.timestamps
    end
  end
end
