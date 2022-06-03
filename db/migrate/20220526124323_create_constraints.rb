# frozen_string_literal: true

class CreateConstraints < ActiveRecord::Migration[7.0]
  def change
    create_table(:constraints, id: :uuid) do |t|
      t.string(:title)

      t.timestamps
    end
  end
end
