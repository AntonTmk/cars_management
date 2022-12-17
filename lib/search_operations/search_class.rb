# frozen_string_literal: true

require_relative '../search_request/car_request'
require_relative 'search_history'
require_relative '../table/cars_table'
require_relative '../file_process'

# class to get the result of a search request
class SearchClass
  include CarsTable
  include SearchHistory
  include FileProcess
  attr_accessor :request, :result

  CAR_DB = 'cars.yml'

  def initialize(req)
    @request = req
    @result = read_filtered_content(CAR_DB)
    sort_result
    @request.total_quantity = @result.length
    record_request(@request) if @result.length.positive?
  end

  def read_filtered_content(filename)
    car_list = read_content(filename)
    car_list.find_all { |n| @request.include?(n) }
  end

  def print_result
    print_table(@result, @request)
  end

  private

  def sort_result
    @result = sort_type?('price') ? sort_by_price : sort_by_date
    @result = @result.reverse if @request.sort_direction.casecmp('asc') != 0
  end

  def sort_type?(type)
    @request.sort_option.casecmp(type).zero?
  end

  def sort_by_price
    @result.sort_by { |v| v['price'] }
  end

  def sort_by_date
    @result.sort_by do |v|
      d, m, y = v['date_added'].split('/')
      [y.to_i, m.to_i, d.to_i]
    end
  end
end
