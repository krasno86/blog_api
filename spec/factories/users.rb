FactoryBot.define do
  factory :user do
    email { 'test@gmail.com' }
    uid {'egewg5hr'}
    password { '12345678' }
    password_confirmation { '12345678' }
    confirmed_at { Time.zone.now }
    role { 'user' }
  end
end
