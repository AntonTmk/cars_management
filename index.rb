# frozen_string_literal: true

require_relative 'config/requirements'

search_request = CarRequest.new
search_result = SearchResult.new(search_request)
search_result.print_result
