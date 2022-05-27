# frozen_string_literal: true

class CreateInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :invitations, id: :uuid do |t|
      t.string :code
      t.references :user, null: true, foreign_key: true, type: :uuid
      t.references :challenge, null: false, foreign_key: true, type: :uuid
      t.references :issuer, null: true, foreign_key: { to_table: :users }, type: :uuid

      t.timestamps
    end
  end
end
