FactoryBot.define do
  factory :modifier_group do
    identifier { "MG_#{Faker::Lorem.word.upcase}" }
    label { Faker::Lorem.word }
    selection_required_min { 1 }
    selection_required_max { 3 }
  end
end
