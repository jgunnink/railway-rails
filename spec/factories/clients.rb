FactoryGirl.define do
  factory :client do
    contact_name  { FFaker::Name.name }
    contact_phone { FFaker::PhoneNumberAU.mobile_phone_number }
    email         { FFaker::Internet.email }
    name          { FFaker::Company.name }

    trait :invalid do
      contact_name  nil
      contact_phone nil
      email         nil
      name          nil
    end
  end
end
