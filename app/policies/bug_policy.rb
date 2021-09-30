# frozen_string_literal: true

class BugPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end
  end

  def new?
    user.qa?
  end

  def create?
    new?
  end

  def update?
    record.creator == user
  end

  def destroy?
    update?
  end

  def assign?
    user.developer?
  end

  def change_status?
    record.developer == user
  end
end
