# frozen_string_literal: true

# == Schema Information
#
# Table name: challenges
#
#  id            :uuid             not null, primary key
#  open          :boolean          default(FALSE), not null
#  subtitle      :string           not null
#  title         :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  constraint_id :uuid             not null
#
# Indexes
#
#  index_challenges_on_constraint_id  (constraint_id)
#
# Foreign Keys
#
#  fk_rails_...  (constraint_id => constraints.id)
#
class Challenge < ApplicationRecord
  has_rich_text :description
  has_many :levels, dependent: :destroy
  has_many :exercises, through: :levels
  has_many :submissions, through: :exercises
  belongs_to :constraint

  validates :title, presence: true, uniqueness: true, length: { maximum: 255, minimum: 3 }

  def high_score
    submissions.passed.group(:user_id).order(score: :desc).limit(1).pluck(:score).first
  end
end
