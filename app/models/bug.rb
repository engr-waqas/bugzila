# frozen_string_literal: true

class Bug < ApplicationRecord
  IMG_SIZE = '300x300'
  IMG_TYPE = 'image/png, image/gif'

  belongs_to :project
  belongs_to :developer, class_name: :User, optional: true
  belongs_to :creator, class_name: :User, foreign_key: :user_id, inverse_of: :bugs

  has_one_attached :screenshot

  validates :title, :status, :bug_type, presence: true
  validates :title, uniqueness: true

  validate :screenshot_type

  enum bug_type: { bug: 0, feature: 1 }
  enum status: { newly: 0, started: 1, resolved: 2 }

  private

  def screenshot_type
    return if screenshot.attached? && !screenshot.content_type.in?(%('image/png image/gif'))

    errors.add(:screenshot, 'must be a PNG or GIF!')
  end
end
