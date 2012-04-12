class Group < ActiveRecord::Base
  attr_accessible :user_id, :title
  validates :user_id, :presence => true
  validates :title, :presence => true, :uniqueness => true, :length => { :within => 6..50 }
  has_many :belongs_to_groups, :foreign_key => "group_id", :dependent => :destroy
  has_many :quizzes
  has_many :users, :through => :belongs_to_groups
end
