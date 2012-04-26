class Answer < ActiveRecord::Base
  validates :user_id, :presence => true
  validates_numericality_of :user_id, :only_integer => true
  validates :quiz_id, :presence => true
  validates_numericality_of :quiz_id, :only_integer => true
end
