class Group < ActiveRecord::Base
  attr_accessible :user_id, :title, :group_category_radio, :price
  validates :user_id, :presence => true
  validates :title, :presence => true, :uniqueness => true, :length => { :within => 6..50 }
  validates :price, :presence => true, :numericality => true
  has_many :quizzes
  # groups : belongs_to_groups = 1:*
  has_many :belongs_to_groups, :foreign_key => "group_id", :dependent => :destroy
  has_many :users, :through => :belongs_to_groups
  belongs_to :user
end
