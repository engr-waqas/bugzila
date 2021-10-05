# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end
  end

  def index?
    user.manager? || user.developer? || user.qa?
  end

  def new?
    user.manager?
  end

  def create?
    new?
  end

  def show?
    record.creator == user || record.enrollments.exists?(user.id)
  end

  def edit?
    record.creator == user
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  def add_user?
    edit?
  end

  def remove_user?
    edit?
  end
end
