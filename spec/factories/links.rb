FactoryGirl.define do
  factory :link do
    title Faker::Hipster.words(2).join(' ')
    url Faker::Internet.url
    user_id :user
  end
end
