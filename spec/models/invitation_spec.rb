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
require "rails_helper"

RSpec.describe(Invitation, type: :model) do
  pending "add some examples to (or delete) #{__FILE__}"
end
