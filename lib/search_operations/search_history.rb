# frozen_string_literal: true

require_relative '../../config/requirements'

# module for saving searches requests
module SearchHistory
  attr_accessor :request, :history

  DEFAULT_REQUESTS_QUANTITY = 1
  HISTORY_FILE_NAME = 'searches.yml'

  def record_request(request)
    @request = request
    @history = FileProcess.read_content(HISTORY_FILE_NAME)
    if !@history
      initialize_file
    else
      edit_history
    end
    FileProcess.update_content(HISTORY_FILE_NAME, @history)
  end

  private

  def initialize_file
    @request.requests_quantity = DEFAULT_REQUESTS_QUANTITY
    @history = [@request.car_hash(DEFAULT_REQUESTS_QUANTITY, @result.length)]
  end

  def edit_history
    if history_include_req?(@history)
      update_request(@history)
    else
      add_request(@history)
    end
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
