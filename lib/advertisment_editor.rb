require_relative 'file_process'
require_relative 'create_table'
require_relative 'car'

class AdvertismentEditor
  include FileProcess
  attr_accessor :car_list
  def adverisment_edit()
  end
  def sellect_ad
    @car_list = read_content('cars.yml')
    @car_list.each { |car| puts "#{@car_list.index(car)}  | #{car}" }
  end

  def add_car
    car = Car.new
    car.params_menu
    car_list << car.to_hash
  end

  def delete_car
    puts 'Input id to delete'
    id = gets.chomp
    car = @car_list.select { |car| car['id'].to_s == id.to_s }
    puts "car: #{car}"
    @car_list -= car
    puts @car_list
  end

  def edit_car
    puts 'Input id to edit'
    id = gets.chomp
    car = @car_list.select { |car| car['id'].to_s == id.to_s }
    puts car
    puts "input parameter name to edit"
    param = gets.chomp
    while !param_edit?(param.to_s)
    puts "input parameter name to edit"
    param = gets.chomp
    puts "type in new value"
    end
    car[0][param] = gets.chomp
  end

  def param_edit?(param)
    case param
    when "make" then true
    when "model" then true
    when "year" then true
    when "price" then true
    when "description" then true
    when "date_added" then true
    else false
    end
  end

  def save_changes
    update_content('cars.yml', @car_list)
  end
end
