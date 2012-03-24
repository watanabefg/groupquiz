# encoding:UTF-8
require 'spec_helper'

describe User do
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
      print @user
    end
    it "sexメソッドが機能すること" do
      @user.should respond_to(:sexes)
    end
  end
end
