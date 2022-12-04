# frozen_string_literal: true

require_relative 'car_request'
require_relative 'file_process'
require_relative 'create_table'
require_relative 'translate_text'

# class to get the result of a search request
class SearchClass
  attr_accessor :request, :result

  def initialize(req)
    @request = req
    require 'yaml'
    car_list = FileProcess.new('cars.yml')
    @result = car_list.file_content.find_all { |n| @request.car_eql_nil?(n) }
    sort_result
    result_quantity if @result.length.positive?
  end

  def print_result
    table = CreateTable.new(table_title)
    table.add_headings(table_heading)
    table.add_content(@result)
    table.table_print
  end

  private

  def table_title
    "#{translate_text('task_title')} \n
    #{translate_text(:total_quantity)}: #{@request.total_quantity}
    #{translate_text(:requests_quantity)}:  #{@request.requests_quantity}"
  end

  def table_heading
    %w[id make model year odometer price description date_added].map { |value| translate_text(value) }
  end

  def translate_text(text)
    @request.translator.translate_content(text).to_s
  end

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

  DEFAULT_REQUESTS_QUANTITY = 1
  def result_quantity
    @request.total_quantity = @result.length
    searches = FileProcess.new('searches.yml')
    unless searches.file_content
      @request.requests_quantity = DEFAULT_REQUESTS_QUANTITY
      searches.file_content = [@request.car_hash(DEFAULT_REQUESTS_QUANTITY, @result.length)]
    else
      edit_history(searches.file_content)
    end
    searches.update_content
  end

  def edit_history(searches)
    if include_req?(searches, @request)
      update_request(searches, @request)
    else
      add_request(searches, @request)
    end
  end

  def add_request(list, req)
    req.requests_quantity = DEFAULT_REQUESTS_QUANTITY
    list << req.car_hash(DEFAULT_REQUESTS_QUANTITY, @result.length)
  end

  def update_request(list, req)
    (0..list.length - 1).each do |v|
      if compare_req?(list[v], req)
        list[v][:requests_quantity] = list[v][:requests_quantity].to_i + 1
        list[v][:total_quantity] = @request.total_quantity.to_i
        @request.requests_quantity = list[v][:requests_quantity].to_i
      end
    end
  end

  def include_req?(searches, request)
    searches.select { |req| compare_req?(req, request) }.length > 0
  end

  def compare_req?(car, req)
    req.car_eql?(car)
  end
end
