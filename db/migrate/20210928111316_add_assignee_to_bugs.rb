# frozen_string_literal: true

class AddAssigneeToBugs < ActiveRecord::Migration[5.2]
  def change
    add_column :bugs, :developer_id, :integer, index: true
  end
end
