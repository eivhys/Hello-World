# frozen_string_literal: true

# == Schema Information
#
# Table name: submissions
#
#  id             :uuid             not null, primary key
#  implementation :string
#  passed         :boolean          default(FALSE)
#  score          :float            default(0.0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  exercise_id    :uuid             not null
#  user_id        :uuid             not null
#
# Indexes
#
#  index_submissions_on_exercise_id  (exercise_id)
#  index_submissions_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (exercise_id => exercises.id)
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe(Submission, type: :model) do
  pending "add some examples to (or delete) #{__FILE__}"
end
