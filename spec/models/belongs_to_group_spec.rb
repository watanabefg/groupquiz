# encoding:UTF-8
require 'spec_helper'

describe BelongsToGroup do
  before(:each) do
    @user = Factory(:user)
    @group = Factory(:group)
    @belongstogroup = @user.belongs_to_groups.build(:group_id => @group.id)
  end

  it "登録できること" do
    @belongstogroup.save!
  end

  describe "Userオブジェクトからのアクセス" do
    before(:each) do
      @belongstogroup.save
    end
    it "belongstogroupインスタンスからuserインスタンスを取得できること" do
      @belongstogroup.user.should == @user
    end
    it "belongstogroupインスタンスからgroupインスタンスを取得できること" do
      @belongstogroup.group.should == @group
    end
  end # Userオブジェクトからのアクセス

  describe "バリデーションの検証" do
    it "user_idが必要" do
      @belongstogroup.user_id = nil
      @belongstogroup.should_not be_valid
    end
    it "group_idが必要" do
      @belongstogroup.group_id = nil
      @belongstogroup.should_not be_valid
    end
  end # バリデーションの検証
end
