# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                        :uuid             not null, primary key
#  admin                     :boolean          default(FALSE)
#  anonymous_on_leaderboards :boolean          default(FALSE)
#  confirmation_sent_at      :datetime
#  confirmation_token        :string
#  confirmed_at              :datetime
#  current_sign_in_at        :datetime
#  current_sign_in_ip        :string
#  date_of_birth             :date
#  display_name              :string
#  email                     :string           default(""), not null
#  encrypted_password        :string           default(""), not null
#  external_id_source        :string
#  failed_attempts           :integer          default(0), not null
#  family_name               :string
#  github_handle             :string
#  given_name                :string
#  last_sign_in_at           :datetime
#  last_sign_in_ip           :string
#  linked_in_handle          :string
#  locked_at                 :datetime
#  onboarded                 :boolean          default(FALSE)
#  open_for_offers           :boolean          default(FALSE)
#  phone_number              :string
#  remember_created_at       :datetime
#  reset_password_sent_at    :datetime
#  reset_password_token      :string
#  sign_in_count             :integer          default(0), not null
#  unconfirmed_email         :string
#  unlock_token              :string
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  external_id               :string
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :claimed_invitations, dependent: :destroy, foreign_key: :claimer_id, class_name: Invitation.name
  has_many :challenges, through: :claimed_invitations
  has_many :exercises, through: :challenges
  has_many :submissions, dependent: :destroy

  validates :email, presence: true

  def full_name
    "#{given_name} #{family_name}"
  end

  def passed_challenges
    raise NotImplementedError
    Challenge.unscoped.select("challenges.*, exercises.*, submissions.*")
      .left_outer_joins(:exercises, :submissions, :levels)
      .where("submissions.user_id = ? AND submissions.passed = TRUE", id)
      .group("challenges.id", "exercises.id", "submissions.id", "levels.id")
      .having("COUNT(DISTINCT exercises.*) <= COUNT(DISTINCT submissions.exercise_id)")
  end

  def passed_exercises
    Exercise.where(id: passed_submissions.pluck(:exercise_id).uniq)
  end

  def passed_submissions
    submissions.passed
  end

  def passed_challenge?(challenge)
    !submissions.where(exercise_id: challenge.exercises.pluck(:id))
      .where(passed: false).count.zero?
  end

  def passed_exercise?(exercise)
    submissions.where(exercise_id: exercise.id).where(passed: true).count.positive?
  end
end
