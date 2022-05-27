# frozen_string_literal: true

class ChallengesController < ApplicationController
  before_action :set_challenge, only: [:show]

  def show; end

  private

  def set_challenge
    @challenge = Challenge.find(params[:id])
  end
end
