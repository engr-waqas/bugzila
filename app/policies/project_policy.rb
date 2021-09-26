# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      @user.projects
    end
  end

  def index?
    true
  end

  def new?
    user.manager?
  end

  def create?
    new?
  end

  def update?
    user.manager? && record.manager == user
  end

  def destroy?
    user.type == 'Manager' && record.manager == user
  end

  def show?
    if user.manager?
      record.manager == user
    elsif user.developer?
      record.users.exists?(user.id)
    else
      true
    end
  end

  def add_user?
    update?
  end

  def remove_user?
    destroy?
  end
end
