class RenameEmailAdressToFishing < ActiveRecord::Migration
  def up
    rename_column :users, :email_adress, :email_address
  end

  def down
    rename_column :users, :email_address, :email_adress
  end
end
