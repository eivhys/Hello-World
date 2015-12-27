# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                        :uuid             not null, primary key
#  admin                     :boolean          default(FALSE)
#  anonymous_on_leaderboards :boolean          default(FALSE)
#  confirmation_sent_at      :datetime
#  confirmation_token        :string
#  confirmed_at              :datetime
#  current_sign_in_at        :datetime
#  current_sign_in_ip        :string
#  date_of_birth             :date
#  display_name              :string
#  email                     :string           default(""), not null
#  encrypted_password        :string           default(""), not null
#  external_id_source        :string
#  failed_attempts           :integer          default(0), not null
#  family_name               :string
#  github_handle             :string
#  given_name                :string
#  last_sign_in_at           :datetime
#  last_sign_in_ip           :string
#  linked_in_handle          :string
#  locked_at                 :datetime
#  onboarded                 :boolean          default(FALSE)
#  open_for_offers           :boolean          default(FALSE)
#  phone_number              :string
#  remember_created_at       :datetime
#  reset_password_sent_at    :datetime
#  reset_password_token      :string
#  sign_in_count             :integer          default(0), not null
#  unconfirmed_email         :string
#  unlock_token              :string
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  external_id               :string
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
require "rails_helper"

RSpec.describe(User, type: :model) do
  pending "add some examples to (or delete) #{__FILE__}"
end
