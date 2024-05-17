# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def show?
    true
  end

  def new?
    user
  end

  def edit?
    record_author?
  end

  def update?
    edit?
  end

  def create?
    new?
  end

  def to_moderate?
    record_author?
  end

  def publish?
    user&.admin?
  end

  def reject?
    user&.admin?
  end

  def archive?
    record_author? || user&.admin?
  end

  private

  def record_author?
    record.user == user
  end
end
