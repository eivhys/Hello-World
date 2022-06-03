# frozen_string_literal: true

class CreateChallenges < ActiveRecord::Migration[7.0]
  def change
    create_table(:challenges, id: :uuid) do |t|
      t.string(:title, null: false)

      t.timestamps
    end
  end
end
