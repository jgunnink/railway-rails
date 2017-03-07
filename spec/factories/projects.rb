FactoryGirl.define do
  factory :project do
    association :client, strategy: :build
    name { FFaker::Conference.name }
    stage { rand 1..5 }

    trait :invalid do
      client  nil
      name    nil
      stage   nil
    end
  end
end
