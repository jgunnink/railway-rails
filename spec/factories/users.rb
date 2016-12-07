FactoryGirl.define do

  factory :user do
    email       { FFaker::Internet.email }
    given_names { FFaker::Name.first_name }
    family_name { FFaker::Name.last_name }
    password    "password"
    role        "member"
    confirmed_at { Time.current }

    trait :admin do
      role "admin"
    end

    trait :member do
      role "member"
    end

    trait :unconfirmed do
      confirmed_at { nil }
    end
  end

end
