# frozen_string_literal: true

class AssessSubmissionJob < ApplicationJob
  queue_as :default

  def perform(submission_id)
    Submission.find(submission_id).tap do |submission|
      submission.results.map(&:benchmark!)
      submission.update!(
        score: submission.results.sum(:time_spent),
        passed: submission.results.pluck(:passed).all?
      )
    end
  end
end
