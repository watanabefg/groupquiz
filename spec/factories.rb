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
