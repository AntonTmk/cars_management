# frozen_string_literal: true

require './config/requirements'

# module for saving searches requests
module SearchHistory
  include FileProcess
  attr_accessor :request, :history

  DEFAULT_REQUESTS_QUANTITY = 1
  HISTORY_FILE_NAME = 'data/searches.yml'

  def record_request(car_request_obj)
    @request = car_request_obj
    @history = read_content(HISTORY_FILE_NAME)
    @history ? edit_history : initialize_file
    update_content(HISTORY_FILE_NAME, @history)
  end

  private

  def initialize_file
    @request.requests_quantity = DEFAULT_REQUESTS_QUANTITY
    @history = [@request.car_hash(DEFAULT_REQUESTS_QUANTITY, @request.total_quantity)]
  end

  def edit_history
    history_include_req?(@history) ? update_request(@history) : add_request(@history)
  end

  def add_request(list)
    @request.requests_quantity = DEFAULT_REQUESTS_QUANTITY
    list << @request.car_hash(DEFAULT_REQUESTS_QUANTITY, @request.total_quantity)
  end

  def update_request(list)
    (0..list.length - 1).each do |v|
      next unless compare_req?(list[v])

      increase_record(list[v], @request.total_quantity)
    end
  end

  def increase_record(record, total_quantity)
    record[:requests_quantity] = record[:requests_quantity].to_i + 1
    record[:total_quantity] = total_quantity.to_i
    @request.requests_quantity = record[:requests_quantity].to_i
  end

  def history_include_req?(searches)
    searches.select { |req| compare_req?(req) }.length.positive?
  end

  def compare_req?(car)
    @request.car_eql?(car)
  end
end
