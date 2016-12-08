FactoryGirl.define do
  factory :project do
    association :client, strategy: :build
    name { FFaker::Name.name }

    trait :invalid do
      client nil
      name   nil
    end
  end
end