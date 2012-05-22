class RemoveGroupCategoryFromGroup < ActiveRecord::Migration
  def up
    remove_column :groups, :group_category
      end

  def down
    add_column :groups, :group_category, :integer
  end
end
