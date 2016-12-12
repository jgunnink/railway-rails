FactoryGirl.define do
  factory :project do
    association :client, strategy: :build
    name { FFaker::Conference.name }

    trait :invalid do
      client nil
      name   nil
    end
  end
end
