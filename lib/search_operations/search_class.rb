# frozen_string_literal: true

require_relative '../../config/requirements'

# class to get the result of a search request
class SearchClass
  attr_accessor :request, :result

  def initialize(req)
    @request = req
    require 'yaml'
    car_list = FileProcess.new('cars.yml')
    @result = car_list.file_content.find_all { |n| @request.car_eql_nil?(n) }
    sort_result
    @request.total_quantity = @result.length
    SearchHistory.result_quantity(@request) if @result.length.positive?
  end

  def print_result
    ResultTable.print_table(@result, @request)
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
