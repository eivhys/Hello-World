# frozen_string_literal: true

class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column(:users, :family_name, :string)
    add_column(:users, :given_name, :string)
    add_column(:users, :date_of_birth, :date)
    add_column(:users, :external_id, :string)
    add_column(:users, :external_id_source, :string)
    add_column(:users, :admin, :boolean, default: false)
    add_column(:users, :anonymous_on_leaderboards, :boolean, default: false)
    add_column(:users, :display_name, :string)
    add_column(:users, :open_for_offers, :boolean, default: false)
    add_column(:users, :onboarded, :boolean, default: false)
    add_column(:users, :linked_in_handle, :string)
    add_column(:users, :github_handle, :string)
    add_column(:users, :phone_number, :string)
  end
end
