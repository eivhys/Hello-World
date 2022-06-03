# frozen_string_literal: true

class SubmissionsController < ApplicationController
  before_action :set_exercise

  def create
    @submission = @exercise.submissions.create(
      implementation: submission_params[:implementation],
      user: current_user
    )

    respond_to do |format|
      format.turbo_stream
      if @submission.valid?
        format.html { redirect_to(@exercise) }
      else
        format.html { redirect_to(@exercise, status: :unprocessable_entity) }
      end
    end
  end

  private

  def submission_params
    params.require(:submission).permit(:implementation)
  end

  def set_exercise
    @exercise = current_user.exercises.find(params[:exercise_id])
  end
end
