# frozen_string_literal: true

class WelcomeController < ApplicationController
  def show
    @invitation = Invitation.new
    @invitations = current_user.invitations
      .includes(
                                 challenge: [levels: [:exercises]]
                               ).order(created_at: :desc)
  end

  def update
    @invitation = Invitation.unclaimed.find_by(code: invitation_params[:code])

    respond_to do |format|
      if @invitation&.update(user: current_user)
        format.turbo_stream { flash.now[:notice] = "You've accepted the invitation! 🎉" }
        format.html { redirect_to(root_url) }
      else
        format.turbo_stream { flash.now[:alert] = "Invitatation code is not valid." }
        format.html { redirect_to(root_url, status: :unprocessable_entity) }
      end
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:code)
  end
end
