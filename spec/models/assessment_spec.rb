# frozen_string_literal: true

# == Schema Information
#
# Table name: assessments
#
#  id          :uuid             not null, primary key
#  hidden      :boolean          default(FALSE), not null
#  input       :string           not null
#  leeway      :integer          default(0), not null
#  timeout     :integer          default(10), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  exercise_id :uuid             not null
#
# Indexes
#
#  index_assessments_on_exercise_id  (exercise_id)
#
# Foreign Keys
#
#  fk_rails_...  (exercise_id => exercises.id)
#
require "rails_helper"

RSpec.describe(Assessment, type: :model) do
  pending "add some examples to (or delete) #{__FILE__}"
end
