FactoryGirl.define do
  factory :user do
    name                    { Faker::Name.name }
    email                   { Faker::Internet.email }
    password                'passw0rd'
    password_confirmation   'passw0rd'
  end
end
