# frozen_string_literal: true

require_relative 'car_request'

# class to get the result of a search request
class SearchClass
  attr_accessor :request, :result

  def initialize(req)
    @request = req
    require 'yaml'
    car_array = YAML.safe_load(File.read('cars.yml'))
    @result = car_array.find_all { |n| @request.car_eql?(n) }
    sort_result
  end

  def print_result
    print = @result.to_s.gsub(/["}\[]/, '').gsub(/[{\]]/, "\n--------------------------------------------\n")
    print = print.gsub(/,/, "\n").gsub(/=>/, ': ')
    puts print
  end

  private

  def sort_result
    @result = if @request.sort_option.casecmp('price') != 0
                @result.sort_by do |v|
                  d, m, y = v['date_added'].split('/')
                  [y.to_i, m.to_i, d.to_i]
                end
              else
                @result.sort_by { |v| v['price'] }
              end
    @result = @result.reverse if @request.sort_direction.casecmp('asc') != 0
  end
end
