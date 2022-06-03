# frozen_string_literal: true

# == Schema Information
#
# Table name: results
#
#  id            :uuid             not null, primary key
#  answer        :string
#  passed        :boolean          not null
#  state         :string           default("pending"), not null
#  time_spent    :float
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
class Result < ApplicationRecord
  module State
    PENDING = "pending"
    RUNNING = "running"
    PASSED = "passed"
    FAILED = "failed"
    ALL = [PENDING, RUNNING, PASSED, FAILED].freeze
  end

  belongs_to :submission
  belongs_to :assessment
  has_one :exercise, through: :assessment
  has_one :challenge, through: :exercise
  has_one :user, through: :submission

  validates :assessment, presence: true
  validates :state, presence: true, inclusion: { in: Result::State::ALL }

  scope :pending, -> { where(state: Result::State::PENDING) }
  scope :running, -> { where(state: Result::State::RUNNING) }
  scope :passed, -> { where(state: Result::State::PASSED) }
  scope :failed, -> { where(state: Result::State::FAILED) }

  after_create_commit -> { broadcast_prepend_to("results") }
  after_update_commit -> { broadcast_replace_to("results") }

  delegate :hidden?, :timeout, to: :assessment

  def benchmark!
    start!
    candidate_outcome = Assessments::Runner.call(submission.implementation, assessment.input, timeout,
      Assessments::Runners::Ruby::Evaluator)
    recruiter_outcome = Assessments::Runner.call(exercise.implementation, assessment.input, timeout,
      Assessments::Runners::Ruby::Evaluator)
    finish!(
      passed: acceptable_solution?(candidate_outcome, recruiter_outcome),
      result: candidate_outcome.result,
      time_spent: candidate_outcome.time_spent
    )
  end

  def passed?
    state == Result::State::PASSED
  end

  def failed?
    state == Result::State::FAILED
  end

  def running?
    state == Result::State::RUNNING
  end

  def pending?
    state == Result::State::PENDING
  end

  def start!
    update!(state: Result::State::RUNNING)
  end

  def finish!(result:, time_spent:, passed: false)
    update!(
      passed: passed,
      answer: result,
      time_spent:,
      state: passed ? Result::State::PASSED : Result::State::FAILED
    )
  end

  private

  def acceptable_upper_time_limit(recruiter_outcome)
    recruiter_outcome.time_spent * (1 + assessment.leeway / 100.0)
  end

  def acceptable_solution?(candidate_outcome, recruiter_outcome)
    candidate_outcome.result == recruiter_outcome.result \
      && candidate_outcome.time_spent <= acceptable_upper_time_limit(recruiter_outcome)
  end
end
