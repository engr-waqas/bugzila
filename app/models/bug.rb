# frozen_string_literal: true

class Bug < ApplicationRecord
  belongs_to :project
  belongs_to :qa, class_name: 'Qa'
  belongs_to :developer, class_name: 'Developer', optional: true

  validates :title, :status, :bug_type, presence: true
  validates :title, uniqueness: true
end
