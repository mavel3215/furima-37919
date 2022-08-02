FactoryBot.define do
  factory :order_address do
    user_id         { "#{rand(1..99999999999)}" }
    item_id         { "#{rand(1..99999999999)}" }
    post_code       { "#{rand(000..999)}-#{rand(0001..9999)}" }
    prefecture_id   {Faker::Number.within(range: 2..48)}
    address1        {Faker::Address.city}
    address2        {Faker::Address.street_address}
    building_name   {Faker::Address.secondary_address}
    phone_number    { "0#{rand(0..9)}0#{rand(1000000..99999999)}" }
    price           {30000}
    token           {"tok_abcdefghik0000000000000"}

  end
end
