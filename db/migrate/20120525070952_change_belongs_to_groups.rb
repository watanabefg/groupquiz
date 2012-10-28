class ChangeBelongsToGroups < ActiveRecord::Migration
  def change
    #add_index :belongs_to_groups, [:user_id, :group_id], unique: true
  end
end
