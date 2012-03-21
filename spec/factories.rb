# encoding:UTF-8
Factory.define :user do |user|
  user.provider  "facebook"
  user.uid  "2309532085"
  user.name "foobar"
end
Factory.define :group do |group|
  group.user_id  "1"
  group.title "タイトルのテスト"
end
Factory.define :belongs_to_group do |belongs_to_group|
  belongs_to_group.user_id "1"
  belongs_to_group.group_id "1"
end
