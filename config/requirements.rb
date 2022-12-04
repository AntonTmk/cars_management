# gems
require 'i18n'
require 'terminal-table'
require 'colorize'
require 'yaml'

# Classes
require_relative '../lib/search_request/car_request'
require_relative '../lib/file_process'
require_relative '../lib/create_table'
require_relative '../lib/search_operations/search_class'


#modules
require_relative '../lib/translate_text'
include TranslateText
require_relative '../lib/search_operations/search_history'
include SearchHistory
require_relative '../lib/search_operations/result_table'
include ResultTable
require_relative '../lib/search_request/compare_requests'
include CompareRequests

#config
require_relative '../config/initializers/i18n'