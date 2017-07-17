FactoryGirl.define do
  factory :link do
    title "link 1"
    url Faker::Internet.url
    user_id :user
  end
end
