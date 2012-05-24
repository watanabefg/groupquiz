class AddPriceToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :price, :decimal

  end
end
