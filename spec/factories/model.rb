FactoryGirl.define do
  factory :model do
    sequence(:name)   { |n| "Model #{n}" }
  end
end
