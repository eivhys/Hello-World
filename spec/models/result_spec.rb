# frozen_string_literal: true

# == Schema Information
#
# Table name: results
#
#  id            :uuid             not null, primary key
#  answer        :string
#  passed        :boolean          not null
#  state         :string           default("pending"), not null
#  time_spent    :decimal(, )
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  assessment_id :uuid             not null
#  submission_id :uuid             not null
#
# Indexes
#
#  index_results_on_assessment_id  (assessment_id)
#  index_results_on_submission_id  (submission_id)
#
# Foreign Keys
#
#  fk_rails_...  (assessment_id => assessments.id)
#  fk_rails_...  (submission_id => submissions.id)
#
require "rails_helper"

RSpec.describe(Result, type: :model) do
  pending "add some examples to (or delete) #{__FILE__}"
end
