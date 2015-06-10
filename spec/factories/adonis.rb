FactoryGirl.define do
  factory :adonis do
    admin_password              'admin'
    deploy_password             'deploy'
    sequence(:hostname)         { |n| "adonis#{n}.example.com" }
    sequence(:identifier)       { |n| "adonis#{n}" }
    sequence(:inventory_number) { |n| "S-AD-#{n}" }
    ipv4_gateway                '192.168.1.254'
    ipv6_gateway                'ac5f:d696:3807:1d72::7d2b:e1df'
    root_password               'root'
    sequence(:serial_number)    { |n| n }
  end
end
