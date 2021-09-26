# frozen_string_literal: true

class Bug < ApplicationRecord
  belongs_to :project
  belongs_to :qa, class_name: 'Qa'
  belongs_to :developer, class_name: 'Developer', optional: true
  has_one_attached :screenshot

  validates :title, :status, :bug_type, presence: true
  validates :title, uniqueness: true

  validate :screenshot_type

  private

  def screenshot_type
    errors.add(:screenshot, 'must be a PNG or GIF!') unless screenshot.content_type.in?(%('image/png image/gif'))
  end
end
