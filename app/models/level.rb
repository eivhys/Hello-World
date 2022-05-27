# frozen_string_literal: true

# == Schema Information
#
# Table name: levels
#
#  id           :uuid             not null, primary key
#  position     :integer          not null
#  title        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  challenge_id :uuid             not null
#
# Indexes
#
#  index_levels_on_challenge_id  (challenge_id)
#
# Foreign Keys
#
#  fk_rails_...  (challenge_id => challenges.id)
#
class Level < ApplicationRecord
  belongs_to :challenge

  has_many :exercises, dependent: :destroy

  validates :title, presence: true
  validates :challenge, presence: true
  validates :position, presence: true, numericality: { only_integer: true }
end
