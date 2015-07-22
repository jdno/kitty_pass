FactoryGirl.define do
  factory :model do
    sequence(:name)   { |n| "Model #{n}" }
    eol               { Time.at(rand * Time.now.to_i) }
  end
end
