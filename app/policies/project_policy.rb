# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.manager? || user.developer?
        @user.projects
      else
        Project.all
      end
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
      record.users.include?(user)
    else
      true
    end
  end

end
