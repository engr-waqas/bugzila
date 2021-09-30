# frozen_string_literal: true

class BugPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve; end
  end

  def index?
    user.qa? || user.developer?
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
    record.creator == user
  end

  def show?
    index?
  end

  def assign?
    user.developer?
  end

  def change_status?
    record.developer == user
  end
end
