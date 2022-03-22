FactoryGirl.define do
  factory :user, class: User do |f|
    f.email 'test@example.com'
    f.password 'password'
  end
end
