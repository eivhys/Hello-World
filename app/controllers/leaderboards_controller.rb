# frozen_string_literal: true

class LeaderboardsController < ApplicationController
  before_action :set_exercise, only: [:show]

  def show
    @leaderboard = @exercise.leaderboard
  end

  private

  def set_exercise
    @exercise = current_user.exercises.find(params[:exercise_id])
  end
end
