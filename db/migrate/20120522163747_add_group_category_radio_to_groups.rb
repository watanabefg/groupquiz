class AddGroupCategoryRadioToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :group_category_radio, :integer

  end
end
