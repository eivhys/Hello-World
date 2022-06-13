# frozen_string_literal: true

# == Schema Information
#
# Table name: challenges
#
#  id            :uuid             not null, primary key
#  open          :boolean          default(FALSE), not null
#  subtitle      :string           not null
#  title         :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  constraint_id :uuid             not null
#
# Indexes
#
#  index_challenges_on_constraint_id  (constraint_id)
#
# Foreign Keys
#
#  fk_rails_...  (constraint_id => constraints.id)
#
require "rails_helper"

RSpec.describe(Challenge, type: :model) do
  pending "add some examples to (or delete) #{__FILE__}"
end
