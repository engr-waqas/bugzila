# frozen_string_literal: true

class BugPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end
  end

  def index?
    user.developer? || user.qa?
  end

  def new?
    user.qa?
  end

  def create?
    new?
  end

  def edit?
    record.creator == user
  end

  def show?
    index?
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  def assign?
    user.developer?
  end

  def change_status?
    record.developer == user
  end
end
