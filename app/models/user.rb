# frozen_string_literal: true

class User < ApplicationRecord
  has_and_belongs_to_many :projects

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable

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
