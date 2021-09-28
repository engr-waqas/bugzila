# frozen_string_literal: true

class User < ApplicationRecord
  has_and_belongs_to_many :projects

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable
  validates_presence_of :name, :type

  def manager?
    type == 'Manager'
  end

  def developer?
    type == 'Developer'
  end

  def qa?
    type == 'Qa'
  end
end
