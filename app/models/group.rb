class Group < ActiveRecord::Base
  attr_accessible :user_id, :title
  validates :user_id, :presence => true
  validates :title, :presence => true, :uniqueness => true, :length => { :within => 6..50 }
end
