# frozen_string_literal: true

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
    @history = []
    add_request(@history)
  end

  def edit_history
    history_includes_request?(@history) ? update_request(@history) : add_request(@history)
  end

  def add_request(list)
    @request.requests_quantity = DEFAULT_REQUESTS_QUANTITY
    @request.id = list.length
    list << @request.car_hash(list.length, DEFAULT_REQUESTS_QUANTITY, @request.total_quantity)
  end

  def update_request(list)
    list.each_with_index do |list_index|
      next unless compare_requests?(list[list_index])

      increase_record(list[list_index], @request.total_quantity)
      @request.id = list_index
    end
  end

  def increase_record(record, total_quantity)
    record[:requests_quantity] = record[:requests_quantity].to_i + 1
    record[:total_quantity] = total_quantity.to_i
    @request.requests_quantity = record[:requests_quantity].to_i
  end

  def history_includes_request?(searches)
    searches.select { |request| compare_requests?(request) }.length.positive?
  end

  def compare_requests?(car)
    @request.car_eql?(car)
  end
end
