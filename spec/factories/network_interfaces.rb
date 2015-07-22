FactoryGirl.define do
  factory :network_interface do
    ipv4_address          { Faker::Internet.ip_v4_address }
    ipv4_netmask          '255.255.255.0'
    ipv6_address          { Faker::Internet.ip_v6_address }
    ipv6_prefix           '64'
    mac_address           { Faker::Internet.mac_address }
    networkable           { create(:adonis) }
    sequence(:name)       { |n| "eth#{n}" }
  end
end
