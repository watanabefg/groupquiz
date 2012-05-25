class AddIndexBelongsToGroups < ActiveRecord::Migration
  def change
    add_index :belongstogroups, [:user_id, :group_id], unique: true
  end
end
