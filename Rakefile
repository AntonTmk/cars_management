require 'faker'

task default: %w[run]

task :run do
  ruby "index.rb"
end

task :add do
  car = Hash.new
  car['id'] = Faker::IDNumber.croatian_id + '-330f-11ec-8d3d-0242ac130003'
  car['make'] = Faker::Vehicle.make
  car['model'] = Faker::Vehicle.model(make_of_model: hash['make'])
  car['year'] = Faker::Vehicle.year
  car['odometer'] = Faker::Vehicle.mileage
  car['price'] = Faker::Commerce.price(range: 1000..100000)
  car['description'] = Faker::Lorem.sentence
  car['date'] = Faker::Date.between(from: '2000-01-01', to: Date.today)
  puts hash

  car_db = YAML.load_file 'cars.yml'
  car_db << car
  File.open('cars.yml','w') { |f| f.write car_db.to_yaml }
end

task :clean do
  Rake::Cleaner.cleanup_files(['searches.yml', 'cars.yml'])
end

task :multi do
  puts 'Input number of new elements'
  max = STDIN.gets.chomp
  (0..5).each { |i|
    Rake::Task["add"].invoke
  }
end