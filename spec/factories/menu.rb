FactoryBot.define do
  factory :menu do
    identifier { "MENU_#{Faker::Lorem.word.upcase}" }
    label { Faker::Lorem.word }
    state { "active" }
    start_date { Date.today }
    end_date { Date.today + 30.days }
  end
end
