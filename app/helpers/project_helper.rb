# frozen_string_literal: true

module ProjectHelper
  def can_create?
    policy(:project).create?
  end

  def can_modify?(project)
    policy(project).create?
  end

  def can_remove?(project, user)
    policy(project).remove_user? && project.enrollments.exists?(user.id)
  end

  def can_add?(project)
    policy(project).add_user?
  end
end
