# frozen_string_literal: true

class AddCreatedByToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :created_by, :integer
  end
end
