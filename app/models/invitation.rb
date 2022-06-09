# frozen_string_literal: true

# == Schema Information
#
# Table name: invitations
#
#  id                       :uuid             not null, primary key
#  claimed_at               :datetime
#  code                     :string
#  validity_time_in_seconds :float
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  challenge_id             :uuid             not null
#  claimer_id               :uuid
#  issuer_id                :uuid
#
# Indexes
#
#  index_invitations_on_challenge_id  (challenge_id)
#  index_invitations_on_claimer_id    (claimer_id)
#  index_invitations_on_issuer_id     (issuer_id)
#
# Foreign Keys
#
#  fk_rails_...  (challenge_id => challenges.id)
#  fk_rails_...  (claimer_id => users.id)
#  fk_rails_...  (issuer_id => users.id)
#
class Invitation < ApplicationRecord
  belongs_to :claimer, class_name: User.name, optional: true
  belongs_to :challenge
  has_many :exercises, through: :challenge
  has_many :levels, through: :exercises

  validates :code, presence: true, uniqueness: true
  validates :claimer_id, uniqueness: { scope: :challenge_id }

  scope :unclaimed, -> { where(claimer: nil) }
  after_update_commit lambda {
    broadcast_prepend_to(
      "invitations",
      partial: "invitations/invitation",
      locals: { invitation: self, user: claimer },
      target: "invitations"
    )
  }
end
