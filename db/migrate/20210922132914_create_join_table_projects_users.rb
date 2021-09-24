# frozen_string_literal: true

class CreateJoinTableProjectsUsers < ActiveRecord::Migration[5.2]
  def change
    create_join_table :projects, :users
  end
end
