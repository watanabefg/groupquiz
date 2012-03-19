class User < ActiveRecord::Base
  has_many :belongs_to_groups, :foreign_key => "user_id", :dependent => :destroy
  has_many :groups, :through => :belongs_to_users

  def self.create_with_omniauth(auth)
    create!do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
    end 
  end 

end
