# frozen_string_literal: true

# == Schema Information
#
# Table name: exercises
#
#  id              :uuid             not null, primary key
#  implementation  :string           not null
#  position        :integer          not null
#  title           :string           not null
#  unlock_criteria :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  level_id        :uuid             not null
#
# Indexes
#
#  index_exercises_on_level_id  (level_id)
#
# Foreign Keys
#
#  fk_rails_...  (level_id => levels.id)
#
require 'rails_helper'

RSpec.describe Exercise, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
