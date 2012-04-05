# encoding:UTF-8
require 'spec_helper'

describe Category do
  before(:each) do
    @attr = {
      :name => "hogehoge"
    }
  end
  it "名前がないと検証NGであること" do
    category = Category.new(@attr.merge(:name => ''))
    category.should_not be_valid
  end
  it "名前が50文字を超えると検証NGであること" do
    long_name = "a"*51
    category = Category.new(@attr.merge(:name => long_name))
    category.should_not be_valid
  end
  it "全て満たした時検証OKであること" do
    category = Category.new(@attr)
    category.should be_valid
  end
  it "名前が重複したら検証NGであること" do
    Category.create!(@attr)
    category = Category.new(@attr)
    category.should_not be_valid
  end
end
