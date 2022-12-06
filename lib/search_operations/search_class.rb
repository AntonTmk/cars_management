# frozen_string_literal: true

require_relative '../../config/requirements'

# class to get the result of a search request
class SearchClass
  attr_accessor :request, :result

  CAR_DB = 'cars.yml'

  def initialize(req)
    @request = req
    @result = read_content(CAR_DB)
    sort_result
    @request.total_quantity = @result.length
    SearchHistory.record_request(@request) if @result.length.positive?
  end

  def read_content(filename)
    car_list = FileProcess.read_content(filename)
    car_list.find_all { |n| @request.car_eql_nil?(n) }
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