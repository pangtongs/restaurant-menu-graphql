FactoryBot.define do
  factory :item do
    item_type { "Product" }
    identifier { "ITEM_#{Faker::Lorem.word.upcase}" }
    label { Faker::Food.dish }
    description { Faker::Food.description }
    price { Faker::Commerce.price(range: 5.0..20.0) }
  end
end
