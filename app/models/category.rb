class Category < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true, :uniqueness => true, :length => {:maximum => 50}
  has_many :quizzes, :foreign_key => 'category_id', :dependent => :destroy
end
