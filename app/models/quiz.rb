class Quiz < ActiveRecord::Base
  validates :category_id, :presence => true
  belongs_to :category
end
