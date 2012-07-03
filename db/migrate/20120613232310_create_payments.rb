class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :user_id
      t.integer :group_id
      t.boolean :shiharaikbn, :default => false

      t.timestamps
    end
  end
end
