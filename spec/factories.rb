# encoding:UTF-8
Factory.define :user do |user|
  user.provider  "facebook"
  user.uid  "2309532085"
  user.name "foobar"
  user.sex_id "1"
  user.email_address "test@test.com"
  user.password "testtest"
  user.possession_medals 0
end
Factory.define :group do |group|
  group.user_id  "1"
  group.title "タイトルのテスト"
  group.price 1000
end
Factory.define :belongs_to_group do |belongs_to_group|
  belongs_to_group.user_id "1"
  belongs_to_group.group_id "1"
end
Factory.define :belongs_to_group_next, :class => BelongsToGroup do |belongs_to_group|
  belongs_to_group.user_id "2"
  belongs_to_group.group_id "1"
end
Factory.define :sex do |sex|
  sex.name "男"
end
Factory.define :sex_next do |sex|
  sex.name "女"
end
