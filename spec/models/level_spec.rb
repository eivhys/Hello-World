# frozen_string_literal: true

# == Schema Information
#
# Table name: levels
#
#  id           :uuid             not null, primary key
#  position     :integer          not null
#  title        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  challenge_id :uuid             not null
#
# Indexes
#
#  index_levels_on_challenge_id  (challenge_id)
#
# Foreign Keys
#
#  fk_rails_...  (challenge_id => challenges.id)
#
require "rails_helper"

RSpec.describe(Level, type: :model) do
  pending "add some examples to (or delete) #{__FILE__}"
end
