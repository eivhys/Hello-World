# frozen_string_literal: true

class GetStartedController < ApplicationController
  include Wicked::Wizard

  skip_before_action :onboard_user

  steps :enter_invitation_code, :complete_profile

  def update
    @user = current_user
    options = {}
    case step
    when :enter_invitation_code
      @invitation = Invitation.unclaimed.find_by(code: invitation_params[:code])
      if @invitation.nil?
        options[:status] = :unprocessable_entity
        flash[:alert] = "Invitation code is not valid"
      elsif @user.onboarded?
        @invitation.update(user: @user)
        flash[:confetti] = "Invitation accepted 🎉"
        redirect_to(root_path)
      else
        @invitation.assign_attributes(user: @user)
        flash[:confetti] = "Invitation accepted 🎉"
        render_wizard(@invitation, options)
      end
    when :complete_profile
      if @user.onboarded?
        redirect_to(root_path)
      else
        @user.assign_attributes(**user_params, onboarded: true)
        render_wizard(@user)
      end
    else
      render_wizard
    end
  end

  def show
    @user = current_user
    case step
    when :enter_invitation_code
    when :complete_profile

    end
    render_wizard
  end

  private

  def user_params
    params.require(:user).permit(:display_name, :given_name, :family_name, :phone_number, :linked_in_url, :github_url,
      :twitter_url, :website_url, :bio, :profile_images, :open_for_offers, :anonymous_on_leaderboards)
  end

  def invitation_params
    params.require(:invitation).permit(:code)
  end
end
