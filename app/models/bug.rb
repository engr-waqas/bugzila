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
    if screenshot.attached?
      if !screenshot.content_type.in?(%('image/png image/gif'))
        errors.add(:screenshot, 'must be a PNG or GIF!')
      end
    end
  end
end
