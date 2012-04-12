class Quiz < ActiveRecord::Base
  validates :category_id, :presence => true
  belongs_to :category
  belongs_to :user
  belongs_to :group
end
