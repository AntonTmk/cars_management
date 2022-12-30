# frozen_string_literal: true

# gems

require 'i18n'
require 'colorize'
require 'terminal-table'
require 'yaml'
require 'date'

# classes

require_relative '../lib/navigation/start_menu'
require_relative '../lib/text_translation'


require_relative '../config/initializers/i18n'

# tables

require './lib/view/table/base_table'
require './lib/view/table/cars_table'

require './lib/file_process'

require './lib/search_request/comparison_requests'
require './lib/search_request/car_request'
require './lib/search_operations/search_history'
require './lib/search_operations/car_search'

