# frozen_string_literal: true

require_relative '../../config/requirements'

# class to get the result of a search request
class SearchResult
  attr_accessor :request, :result

  def initialize(req)
    @request = req
    car_list = FileProcess.read_content('cars.yml')
    @result = car_list.find_all { |n| @request.car_eql?(n) }
    @request.total_quantity = @result.length
    sort_result
    SaveRequest.request_save(@request) if @result.length.positive?
  end

  def print_result
    puts "-------------------------------------------- \n Statistic: \n \n"
    puts "Total Quanity: #{@request.total_quantity} \n \nRequests quantity:  #{@request.requests_quantity} "
    print = @result.to_s.gsub(/["}\[]/, '').gsub(/[{\]]/, "\n--------------------------------------------\n")
    print = print.gsub(/,/, "\n").gsub(/=>/, ': ')
    puts print
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
