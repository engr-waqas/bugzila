# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :manager, class_name: 'Manager'
  has_and_belongs_to_many :users
  has_and_belongs_to_many :developers, join_table: 'projects_users', association_foreign_key: 'user_id'
  has_and_belongs_to_many :qas, join_table: 'projects_users', association_foreign_key: 'user_id'

  validates :title, presence: true,
                    format: { with: /\A[a-zA-Z]+\z/,
                              message: 'should contain only letters' }
end
