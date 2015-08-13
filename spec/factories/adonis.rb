FactoryGirl.define do
  sequence :hostname do |n|
    "adonis#{n}.example.com"
  end

  sequence :identifier do |n|
    "adonis#{n}"
  end

  sequence :inventory_number do |n|
    "INVENTORY-#{n}"
  end

  sequence :serial_number do |n|
    "SERIAL-#{n}"
  end

  factory :adonis do
    admin_password              'admin'
    deploy_password             'deploy'
    hostname                    { generate :hostname }
    identifier                  { generate :identifier }
    inventory_number            { generate :inventory_number }
    ipv4_gateway                '192.168.1.254'
    ipv6_gateway                'ac5f:d696:3807:1d72::7d2b:e1df'
    root_password               'root'
    serial_number               { generate :serial_number }
    snmp_community              'public'
    syslog_server               '192.168.1.24'
  end
end
