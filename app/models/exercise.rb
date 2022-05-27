# frozen_string_literal: true

# == Schema Information
#
# Table name: exercises
#
#  id              :uuid             not null, primary key
#  implementation  :string           not null
#  position        :integer          not null
#  title           :string           not null
#  unlock_criteria :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  level_id        :uuid             not null
#
# Indexes
#
#  index_exercises_on_level_id  (level_id)
#
# Foreign Keys
#
#  fk_rails_...  (level_id => levels.id)
#
class Exercise < ApplicationRecord
  has_rich_text :description

  belongs_to :level
  has_one :challenge, through: :level
  has_many :assessments, dependent: :destroy, class_name: Assessment.name
  has_many :submissions, dependent: :destroy, class_name: Submission.name
  has_many :results, through: :submissions, dependent: :destroy

  validates :title, presence: true
  validates :level, presence: true
  validates :position, presence: true, numericality: { only_integer: true }
end
