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
    user.qa? || user.developer?
  end

  def new?
    user.qa? && record.project.users.exists?(user.id)
  end

  def create?
    new?
  end

  def edit?
    update?
  end

  def update?
    user.qa? && record.qa == user
  end

  def destroy?
    user.qa? && record.qa == user
  end

  def show?
    index?
  end

  def assign?
    user.developer?
  end

  def change_status?
    user.developer? && record.developer == user
  end
end
