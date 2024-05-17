# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :bulletins, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['bulletins']
  end
end
