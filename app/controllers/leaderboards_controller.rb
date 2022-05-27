# frozen_string_literal: true

class LeaderboardsController < ApplicationController
  before_action :set_challenge, only: [:show]

  def show
    @by_score = @challenge.submissions.passed.order(score: :asc).limit(10)
  end

  private

  def set_challenge
    @challenge = current_user.challenges.find(params[:challenge_id])
  end
end
