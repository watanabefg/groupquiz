class AddBirthdayAndSexAndEmailAddressAndPasswordToUsers < ActiveRecord::Migration
  def change
    add_column :users, :birthday, :date

    add_column :users, :sex, :integer

    add_column :users, :email_adress, :string

    add_column :users, :password, :string

  end
end
