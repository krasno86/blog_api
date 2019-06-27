FactoryBot.define do
  factory :task do
    name { Faker::StarWars.planet }
    description { 'description' }
  end
end
