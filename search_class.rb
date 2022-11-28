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
    result_quantity if @result.length > 0
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

  def result_quantity
    @request.total_quantity = @result.length
    require 'yaml'
    searches = YAML.load(File.read('searches.yml'))
    if searches == false
      searches = [@request.car_hash(1, @result.length)]
    else
      edit_history(searches)
    end
    File.write('searches.yml', searches.to_yaml)
  end

  def edit_history(searches)
    if !searches.find { |v| v.to_s.casecmp(@request.car_hash(v[:requests_quantity], v[:total_quantity]).to_s) }.nil?
      (0..searches.length - 1).each do |v|
       next unless searches[v].to_s.casecmp(@request.car_hash(searches[v][:requests_quantity], searches[v][:total_quantity]).to_s).zero?

        searches[v][:requests_quantity] += 1
        searches[v][:total_quantity] = @request.total_quantity
        @request.requests_quantity = searches[v][:requests_quantity]
      end
    else
      @request.requests_quantity = 1
      searches << @request.car_hash(1, @result.length)
    end
  end
end
