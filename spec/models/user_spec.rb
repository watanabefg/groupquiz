# encoding:UTF-8
require 'spec_helper'

describe User do
  describe "get 'new'" do
    before(:each) do
      @attr = {
        :name => "hogetarou", 
      }
    end
    it "名前がないと検証NGであること" do
      user = User.new(@attr.merge(:name => ''))
      user.should_not be_valid
    end
    it "名前が50文字をこえると検証NGであること" do
      long_name = "a"*51
      user = User.new(@attr.merge(:name => long_name))
      user.should_not be_valid
    end
    it "検証OK" do
      user = User.new(@attr)
      user.should be_valid
    end

  end

  describe "belongs_to_groups" do
    before(:each) do
      @user = Factory(:user)
    end

    it "belongs_to_groupsメソッドが機能すること" do
      @user.should respond_to(:belongs_to_groups)
    end
    it "groupsメソッドが機能すること" do
      @user.should respond_to(:groups)
    end
  end # belongs_to_groups
  describe "sex" do
    before(:each) do
      @user = Factory(:user)
      @sex = Factory(:sex)
    end
    it "sexメソッドが機能すること" do
      @user.should respond_to(:sex)
    end
  end
end
