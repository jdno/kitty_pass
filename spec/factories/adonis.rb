FactoryGirl.define do
  factory :adonis do
    admin_password              'admin'
    deploy_password             'deploy'
    sequence(:hostname)         { |n| "adonis#{n}.example.com" }
    sequence(:identifier)       { |n| "adonis#{n}" }
    sequence(:inventory_number) { |n| "S-AD-#{n}" }
    root_password               'root'
    sequence(:serial_number)    { |n| n }
  end
end
