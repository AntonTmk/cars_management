# frozen_string_literal: true

require_relative '../../config/requirements'

# module for saving requests history
module SaveRequest
  attr_accessor :request, :result
  HISTORY_FILE = 'searches.yml'
  DEFAULT_REQUESTS_QUANTITY = 1
  def request_save(request)
    @request = request
    searches = FileProcess.read_content(HISTORY_FILE)
    unless searches
      @request.requests_quantity = DEFAULT_REQUESTS_QUANTITY
      searches = [@request.car_hash(DEFAULT_REQUESTS_QUANTITY, @request.total_quantity)]
    else
      edit_history(searches)
    end
    FileProcess.update_content(HISTORY_FILE, searches)
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
    list << req.car_hash(DEFAULT_REQUESTS_QUANTITY, @request.total_quantity)
  end

  def update_request(list, req)
    (0..list.length - 1).each do |v|
      next unless compare_req?(list[v], req)

      list[v][:requests_quantity] += 1
      list[v][:total_quantity] = req.total_quantity
      req.requests_quantity = list[v][:requests_quantity]
    end
  end

  def include_req?(searches, request)
    searches.select { |req| compare_req?(req, request) }.length.positive?
  end

  def compare_req?(req1, req2)
    req1.to_s.casecmp(req2.car_hash(req1[:requests_quantity], req1[:total_quantity]).to_s).zero?
  end
end
