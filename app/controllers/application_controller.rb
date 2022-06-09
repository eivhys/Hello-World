# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :onboard_user

  protected

  def onboard_user
    if current_user
      unless current_user.onboarded?
        if current_user.claimed_invitations.count.zero?
          redirect_to(get_started_path(:enter_invitation_code))
        else
          redirect_to(get_started_path(:complete_profile))
        end
      end
    end
  end
end
