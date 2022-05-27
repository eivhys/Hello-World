# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.default_scope
    order(created_at: :asc)
  end
end
