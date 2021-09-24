# frozen_string_literal: true

class AddDeveloperIdToBugs < ActiveRecord::Migration[5.2]
  def change
    add_column :bugs, :developer_id, :integer
  end
end
