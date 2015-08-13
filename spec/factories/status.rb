FactoryGirl.define do
  factory :status do
    sequence(:name)   { |n| "#{Faker::Commerce.product_name} #{n}" }
  end
end
