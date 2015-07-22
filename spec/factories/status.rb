FactoryGirl.define do
  factory :status do
    sequence(:name)   { Faker::Commerce.product_name }
  end
end
