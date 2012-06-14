# encoding:UTF-8
require 'spec_helper'

describe Payment do
  before(:each) do
    @attr = {
      :user_id => 1,
      :group_id => 1,
      :shiharaikbn => true,
    }
  end

  it "ユーザーIDがないと検証NGであること" do
    payment = Payment.new(@attr.merge(:user_id => nil))
    payment.should_not be_valid
  end
  it "グループIDがないと検証NGであること" do
    payment = Payment.new(@attr.merge(:group_id => nil))
    payment.should_not be_valid
  end
  it "支払い区分がないと検証NGであること" do
    payment = Payment.new(@attr.merge(:shiharaikbn => nil))
    payment.should_not be_valid
  end
  it "全てデータがあれば検証OKであること" do
    payment = Payment.new(@attr)
    payment.should be_valid
  end
  it "1つのグループIDに同一ユーザーのレコードは挿入できないこと" do
    Factory(:payment)
    payment = Payment.new(@attr)
    payment.should_not be_valid
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
