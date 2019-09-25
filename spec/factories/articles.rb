FactoryBot.define do
  factory :article do
    name { Faker::StarWars.planet }
    description { 'description' }
  end
end
