class ChangePayments < ActiveRecord::Migration
  def change
    add_index :payments, [:user_id, :group_id], unique: true
  end
end
