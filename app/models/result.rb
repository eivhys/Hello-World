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

  after_create_commit { broadcast_prepend_to :result }
  after_update_commit { broadcast_replace_to :result }

  delegate :hidden?, :timeout, to: :assessment

  def benchmark!
    # The implementation is considered safe when it has passed the initial test as it doesn't use any of the unallowed methods.
    return unless passed?

    instance_eval(submission.implementation)
    update!(
      time_spent: Benchmark.measure do
        50_000.times do
          solution(assessment.input)
        end
      end.real
    )
  end

  def evaluate!
    start!
    candidate_outcome = Assessments::Runner.call(
      submission.implementation,
      assessment.input,
      Assessments::Runners::Ruby::Evaluator,
      timeout,
    )
    recruiter_outcome = Assessments::Runner.call(
      exercise.implementation,
      assessment.input,
      Assessments::Runners::Ruby::Evaluator,
      timeout,
    )
    finish!(
      passed: acceptable_solution?(candidate_outcome, recruiter_outcome),
      result: candidate_outcome.result,
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

  def finished?
    failed? || passed?
  end

  def start!
    update!(state: Result::State::RUNNING)
  end

  def finish!(result:, passed: false)
    update!(
      passed: passed,
      answer: result,
      state: passed ? Result::State::PASSED : Result::State::FAILED
    )
  end

  private

  def acceptable_upper_time_limit(recruiter_outcome)
    recruiter_outcome.time_spent * (1 + assessment.leeway / 100.0)
  end

  def acceptable_solution?(candidate_outcome, recruiter_outcome)
    same_return_value?(candidate_outcome, recruiter_outcome) &&
      within_acceptable_time_limit?(candidate_outcome, recruiter_outcome) &&
      !candidate_outcome.result.nil?
  end

  def same_return_value?(candidate_outcome, recruiter_outcome)
    candidate_outcome.result == recruiter_outcome.result
  end

  def within_acceptable_time_limit?(candidate_outcome, recruiter_outcome)
    candidate_outcome.time_spent <= acceptable_upper_time_limit(recruiter_outcome)
  end
end
