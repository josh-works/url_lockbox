FactoryGirl.define do

  factory :user do
    email Faker::Internet.email
    password "password"

    factory :user_with_links do
      links {create_list(:link, 3)}
    end
  end
end
