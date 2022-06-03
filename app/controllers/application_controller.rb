# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :onboard_user

  protected

  def onboard_user
    if current_user
      redirect_to(get_started_path(:enter_invitation_code)) unless current_user.onboarded?
    end
  end
end
