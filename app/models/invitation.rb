# frozen_string_literal: true

# == Schema Information
#
# Table name: invitations
#
#  id           :uuid             not null, primary key
#  code         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  challenge_id :uuid             not null
#  issuer_id    :uuid
#  user_id      :uuid
#
# Indexes
#
#  index_invitations_on_challenge_id  (challenge_id)
#  index_invitations_on_issuer_id     (issuer_id)
#  index_invitations_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (challenge_id => challenges.id)
#  fk_rails_...  (issuer_id => users.id)
#  fk_rails_...  (user_id => users.id)
#
class Invitation < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :challenge
  has_many :exercises, through: :challenge
  has_many :levels, through: :exercises

  validates :code, presence: true, uniqueness: true
  validates :user_id, uniqueness: { scope: :challenge_id }

  scope :unclaimed, -> { where(user_id: nil) }
  after_update_commit lambda {
                        broadcast_prepend_to("invitations", partial: "invitations/invitation", locals: { invitation: self },
                          target: "invitations")
                      }
end
