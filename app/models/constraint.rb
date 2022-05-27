# frozen_string_literal: true

# == Schema Information
#
# Table name: constraints
#
#  id         :uuid             not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Constraint < ApplicationRecord
  has_rich_text :description
end
