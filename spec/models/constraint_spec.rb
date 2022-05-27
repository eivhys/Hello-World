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
require 'rails_helper'

RSpec.describe Constraint, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
