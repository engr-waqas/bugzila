# frozen_string_literal: true

class CreateBugs < ActiveRecord::Migration[5.2]
  def change
    create_table :bugs do |t|
      t.string :title
      t.text :description
      t.datetime :deadline
      t.string :bug_type
      t.string :status
      t.string :screenshot
      t.integer :project_id

      t.timestamps
    end
    add_index :bugs, :title
  end
end
