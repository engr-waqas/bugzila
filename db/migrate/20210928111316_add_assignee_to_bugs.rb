class AddAssigneeToBugs < ActiveRecord::Migration[5.2]
  def change
    add_column :bugs, :developer_id, :integer, index: true
  end
end
