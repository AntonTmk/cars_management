# frozen_string_literal: true

# class to get the result of a search request
class CarSearch
  include SearchHistory
  include FileProcess
  attr_accessor :request, :result

  CAR_DB = 'data/cars.yml'

  def search_by_request(car_request_obj)
    @request = car_request_obj
    @result = read_filtered_content(CAR_DB)
    @request.total_quantity = @result.length
    record_request(@request) if @result.length.positive?
  end

  def read_filtered_content(filename)
    car_list = read_content(filename)
    car_list.find_all { |car| @request.include?(car) }
  end

  include Views

  def print_result
    sort_result
    Views::Render.instance.render_table(table: Views::Table::CarsTable,
                            data: { requests_quantity: @request.requests_quantity, total_quantity: @request.total_quantity, content: @result})
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
    @result.sort_by { |car| car['price'] }
  end

  def sort_by_date
    @result.sort_by { |car| Date.strptime(car['date_added'], '%d/%m/%y') }
  end
end
