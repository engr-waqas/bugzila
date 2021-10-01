# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :user_projects, dependent: :destroy
  has_many :enrollments, through: :user_projects, source: :user
  has_many :bugs, dependent: :destroy
  belongs_to :creator, class_name: 'User'

  validates :title, presence: true

  def self.users_except_manager
    User.where.not(user_type: :manager)
  end
end
