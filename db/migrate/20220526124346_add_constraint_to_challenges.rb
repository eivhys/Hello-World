# frozen_string_literal: true

class AddConstraintToChallenges < ActiveRecord::Migration[7.0]
  def change
    add_reference :challenges, :constraint, null: false, foreign_key: true, type: :uuid
  end
end
