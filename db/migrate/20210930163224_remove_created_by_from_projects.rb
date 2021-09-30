# frozen_string_literal: true

class RemoveCreatedByFromProjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :projects, :created_by, :integer
  end
end
