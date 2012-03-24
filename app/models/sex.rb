class Sex < ActiveRecord::Base
  attr_accessible :name
  has_many :users, :foreign_key => "sex_id", :dependent => :destroy
end
