# frozen_string_literal: true

module BugsHelper
  def can_report?
    policy(:bug).new?
  end

  def can_modify?(bug)
    policy(bug).update?
  end

  def attached?(bug)
    bug.screenshot.attached?
  end

  def can_assign?(bug)
    policy(bug).assign? && bug.newly?
  end

  def can_resolve?(bug)
    policy(bug).change_status?
  end
end
