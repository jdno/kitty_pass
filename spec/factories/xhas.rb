FactoryGirl.define do
  factory :xha do
    sequence(:master) { create :adonis }
    sequence(:slave)  { create :adonis }
  end
end
