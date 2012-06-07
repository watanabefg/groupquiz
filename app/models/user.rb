class User < ActiveRecord::Base
  attr_accessible :name, :birthday, :sex_id, :email_address, :password
  validates :name, :presence => true, :length => {:maximum => 50}
  # users : belongs_to_groups = 1:*
  has_many :belongs_to_groups, :foreign_key => "user_id", :dependent => :destroy
  has_many :groups, :through => :belongs_to_groups
  has_many :quiz, :foreign_key => "user_id", :dependent => :destroy
  belongs_to :sex

  def self.create_with_omniauth(auth)
    create!do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      if auth["provider"].to_s == "facebook" then
        user.name = auth["info"]["name"]
        user.email_address = auth["info"]["email"]
      elsif auth["provider"].to_s == "twitter" then
        user.name = auth["user_info"]["name"]
      end
      #if auth["gender"] === "male" then
      #  user.sex_id = 1
      #else
      #  user.sex_id = 2
      #end
      # user.registration_date = 
      user.Account_information_flag = 0
      user.possession_medals = 5
      user.number_of_login = 1
    end 
  end 

  def pointup(num)
    if !self.possession_medals.nil?
      self.possession_medals = self.possession_medals + num
    end
  end

end
