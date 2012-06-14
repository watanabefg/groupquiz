class Payment < ActiveRecord::Base
  attr_accessible :user_id, :group_id, :shiharaikbn
  validates :user_id, :presence => true, :uniqueness => {:scope => :group_id}
  validates :group_id, :presence => true
  validates :shiharaikbn, :presence => true
end
