# frozen_string_literal: true

class BugPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      Bug.all
    end
  end

  def index?
    true
  end

  def new?
    user.qa?
  end

  def create?
    new?
  end

  def update?
    user.qa? && record.qa == user
  end

  def destroy?
    user.qa? && record.qa == user
  end

  def show?
    true
  end
end
