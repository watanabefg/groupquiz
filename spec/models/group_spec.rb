# encoding:UTF-8
require 'spec_helper'

describe Group do
  describe "fundamental" do
    before(:each) do
      @attr = {
        :user_id => 1, 
        :title => "グループテスト", 
      }
    end

    it "ユーザーIDがないと検証NGであること" do
      group = Group.new(@attr.merge(:user_id => ""))
      group.should_not be_valid
    end

    it "タイトルがないと検証NGであること" do
      group = Group.new(@attr.merge(:title => ""))
      group.should_not be_valid
    end

    it "タイトルが6文字未満だとスパムの疑いがあるので、検証NGであること" do
      short = "a"*5
      group = Group.new(@attr.merge(:title => short))
      group.should_not be_valid
    end

    it "タイトルが50文字を超えると検証NGであること" do
      longname = "a"*51
      group = Group.new(@attr.merge(:title => longname))
      group.should_not be_valid
    end

    it "全て満たしているとき検証OKであること" do
      group = Group.new(@attr)
      group.should be_valid
    end
  end

  describe "連関エンティティ関係" do
    before(:each) do
      @group = Factory(:group)
    end
    it "belongs_to_groupsメソッドが機能すること" do
      @group.should respond_to(:belongs_to_groups)
    end
    it "usersメソッドが機能すること" do
      @group.should respond_to(:users)
    end
  end

  describe "グループ数の制限" do
    before(:each) do
      @attr = {
        :user_id => 2, 
        :title => "グループテスト", 
      }
    end

    it "ユーザーが作成可能グループ数を超えてグループを作ろうとすると検証NGであること" do
      group = Group.new(@group)
      group.should be_valid
    end
  end
end
