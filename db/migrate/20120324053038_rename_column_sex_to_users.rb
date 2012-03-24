class RenameColumnSexToUsers < ActiveRecord::Migration
  def up
    rename_column :users, :sex, :sex_id
  end

  def down
    rename_column :users, :sex_id, :sex
  end
end
