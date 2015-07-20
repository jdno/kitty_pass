require 'factory_girl'

namespace :dev do
  desc 'Fill the development database with dummy data'
  task create_data: :environment do
    Dir[Rails.root.join('spec/factories/**/*.rb')].each { |f| require f }

    locations = 5.times.collect { FactoryGirl.create :location }
    models =    3.times.collect { FactoryGirl.create :model }
    statuses =  3.times.collect { FactoryGirl.create :status }

    25.times do
      adonis = FactoryGirl.build(:adonis, location: locations[rand(0..4)], model: models[rand(0..2)], status:
                                        statuses[rand(0..2)])
      adonis.network_interfaces = 2.times.collect { FactoryGirl.create :network_interface, networkable: adonis }
      adonis.save!
    end

    3.times do
      proteus = FactoryGirl.build(:proteus, location: locations[rand(0..4)], model: models[rand(0..2)], status:
                                              statuses[rand(0..2)])
      proteus.network_interfaces = [FactoryGirl.create(:network_interface, networkable: proteus)]
      proteus.save!
    end

    u = User.create!(name: 'Admin', email: 'admin@example.com', password: 'password', password_confirmation: 'password')
    u.confirm
  end
end
