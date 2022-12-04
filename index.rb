# frozen_string_literal: true

require_relative 'config/requirements'

TranslateText.available_languages
search_request = CarRequest.new
search_result = SearchClass.new(search_request)
search_result.print_result
