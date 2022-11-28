# frozen_string_literal: true

require_relative 'search_class'
require_relative 'car_request'
search_request = CarRequest.new
search_result = SearchClass.new(search_request)
search_result.print_result
