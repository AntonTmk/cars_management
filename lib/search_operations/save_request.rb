# frozen_string_literal: true

require_relative '../../config/requirements'

# module for saving requests history
module SaveRequest
  attr_accessor :request, :result

  HISTORY_FILE = 'searches.yml'
  DEFAULT_REQUESTS_QUANTITY = 1
  def request_save(request)
    @request = request
    @result = FileProcess.read_content(HISTORY_FILE)
    @result ? edit_history : initialize_file
    FileProcess.update_content(HISTORY_FILE, @result)
  end

  private

  def initialize_file
    @request.requests_quantity = DEFAULT_REQUESTS_QUANTITY
    @result = [@request.car_hash(DEFAULT_REQUESTS_QUANTITY, @request.total_quantity)]
  end

  def edit_history
    result_include_req? ? update_request : add_request_to_result
  end

  def add_request_to_result
    @request.requests_quantity = DEFAULT_REQUESTS_QUANTITY
    @result << @request.car_hash(DEFAULT_REQUESTS_QUANTITY, @request.total_quantity)
  end

  def update_request
    (0..@result.length - 1).each do |v|
      next unless compare_req?(@result[v], @request)

      @result[v][:requests_quantity] += 1
      @result[v][:total_quantity] = @request.total_quantity
      @request.requests_quantity = @result[v][:requests_quantity]
    end
  end

  def result_include_request?
    @result.select { |req| compare_req?(req, @request) }.length.positive?
  end

  def compare_request?(req1, req2)
    req1.to_s.casecmp(req2.car_hash(req1[:requests_quantity], req1[:total_quantity]).to_s).zero?
  end
end
