# frozen_string_literal: true

class CreateBugs < ActiveRecord::Migration[5.2]
  def change
    create_table :bugs do |t|
      t.string :title, null: false, default: ''
      t.text :description
      t.datetime :deadline, null: false, default: Time.now.getlocal + 1.month
      t.integer :bug_type, default: 0
      t.integer :status, default: 0
      t.references :project, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
    add_index :bugs, :title, unique: true
  end
end
