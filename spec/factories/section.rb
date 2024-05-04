FactoryBot.define do
  factory :section do
    identifier { "SECTION_#{Faker::Lorem.word.upcase}" }
    label { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
  end
end
