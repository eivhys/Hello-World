# frozen_string_literal: true

class CreateResults < ActiveRecord::Migration[7.0]
  def change
    create_table :results, id: :uuid do |t|
      t.boolean :passed, null: false
      t.string :answer
      t.float :time_spent
      t.string :state, null: false, default: 'pending'
      t.references :submission, null: false, foreign_key: true, type: :uuid
      t.references :assessment, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
