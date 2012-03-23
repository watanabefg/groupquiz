class AddRegistrationDateAndTermOfValidityAndAccountInformationFlagAndPossessionMedalsAndLastLoginTimeAndNumberOfLoginToUsers < ActiveRecord::Migration
  def change
    add_column :users, :registration_date, :date

    add_column :users, :term_of_validity, :date

    add_column :users, :Account_information_flag, :integer

    add_column :users, :possession_medals, :integer

    add_column :users, :last_login_time, :datetime

    add_column :users, :number_of_login, :integer

  end
end
