# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :category

  has_one_attached :image

  validates :title, presence: true, length: { minimum: 2, maximum: 50 }
  validates :description, presence: true, length: { minimum: 5, maximum: 1000 }
  validates :image, attached: true,
                    content_type: %i[png jpg jpeg],
                    size: { less_than: 5.megabytes }

  scope :with_category, -> { includes(:category) }
  scope :default_order, -> { order(created_at: :desc) }
  scope :default_query_bulletins, -> {
    with_attached_image
      .with_category
      .default_order
  }

  aasm column: :state do
    state :draft, initial: true
    state :under_moderation, :published, :rejected, :archived

    event :to_moderate do
      transitions from: :draft, to: :under_moderation
    end

    event :archive do
      transitions from: %i[draft under_moderation published rejected], to: :archived
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[category image_attachment image_blob user]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[state title]
  end
end
