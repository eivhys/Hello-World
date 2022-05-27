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
class Submission < ApplicationRecord
  belongs_to :user
  belongs_to :exercise
  has_many :assessments, through: :exercise
  has_many :results, dependent: :destroy

  validates :user, presence: true
  validates :exercise, presence: true
  validates :implementation, presence: true

  after_create :initiate_results
  after_create :assess_submission

  scope :passed, -> { where(passed: true) }

  before_create -> { implementation.chomp! }

  def assess_submission
    AssessSubmissionJob.perform_later(id)
  end

  def calculate_score!
    update!(score: implementation.split("\n").count / results.average(:time_spent))
  end

  def initiate_results
    assessments.each do |assessment|
      assessment.results.create(submission: self, state: Result::State::PENDING, passed: false)
    end
  end
end
