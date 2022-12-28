task default: %w[run]

task :run do
  ruby "index.rb"
end

task :add do
  ruby "lib/car_db_manage/add_car.rb"
end

task :clean do
  Rake::Cleaner.cleanup_files(['searches.yml', 'cars.yml'])
end

task :add_few do
  puts 'Input number of new elements'
  cars = STDIN.gets.chomp
  (0..cars.to_i).each { |i|
    ruby "lib/car_db_manage/add_car.rb"
  }
end