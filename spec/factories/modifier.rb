FactoryBot.define do
  factory :modifier do
    association :item
    association :modifier_group
    display_order { Faker::Number.between(from: 1, to: 10) }
    default_quantity { Faker::Number.between(from: 0, to: 2) }
    price_override { Faker::Commerce.price(range: 1.0..5.0) }
  end
end
