# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable

  has_many :projects, foreign_key: 'creator_id', dependent: :destroy
  has_many :user_projects, dependent: :destroy
  has_many :enrollments, through: :user_projects, source: :project
  has_many :bugs, dependent: :destroy

  validates :name, :user_type, presence: true

  enum user_type: { manager: 0, developer: 1, qa: 2 }

  def self.except_manager
    User.where.not(user_type: :manager)
  end
end
