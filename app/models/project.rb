class Project < ApplicationRecord
  validates :title, presence: true,
                    format: { with: /\A[a-zA-Z]+\z/,
                              message: 'should contain only letters' },
                    uniqueness: true
end
