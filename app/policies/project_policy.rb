# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end
  end

  def create?
    user.manager?
  end

  def update?
    user.manager? && record.creator == user
  end

  def destroy?
    update?
  end

  def add_user?
    update?
  end

  def remove_user?
    destroy?
  end
end
