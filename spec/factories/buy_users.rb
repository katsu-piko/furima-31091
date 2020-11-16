FactoryBot.define do
  factory :buy_user do
    postal_code { '000-0000' }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city { '横浜市緑区' }
    address { '青山１−１−１' }
    building { '柳ビル' }
    phone_number { Faker::PhoneNumber.subscriber_number(length: 10) }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
