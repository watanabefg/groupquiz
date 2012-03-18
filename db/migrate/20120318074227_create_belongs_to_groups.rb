class CreateBelongsToGroups < ActiveRecord::Migration
  def change
    create_table :belongs_to_groups do |t|
      t.integer :user_id
      t.integer :group_id
      t.timestamps
    end
    add_index :belongs_to_groups, :user_id
    add_index :belongs_to_groups, :group_id
  end
end
