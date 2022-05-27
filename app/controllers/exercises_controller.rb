# frozen_string_literal: true

class ExercisesController < ApplicationController
  before_action :set_exercise, only: [:show]

  def show
    @submissions = current_user.submissions.where(exercise: @exercise)
    @last_submission = @submissions.last
  end

  private

  def set_exercise
    @exercise = Exercise.find(params[:id])
  end
end
