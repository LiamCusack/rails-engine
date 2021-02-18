FactoryBot.define do
  factory :item do
    name { "MyString" }
    description { Faker::Hacker.say_something_smart }
    unit_price { 1.5 }
    merchant
  end
end
