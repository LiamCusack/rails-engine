FactoryBot.define do
  factory :transaction do
    invoice { nil }
    credit_card_number { "MyString" }
    credit_card_expiration { "2021-02-17" }
    result { "MyString" }
  end
end
