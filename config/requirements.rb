# frozen_string_literal: true

# gems

require 'i18n'
require 'terminal-table'
require 'colorize'
require 'yaml'
require 'bcrypt'

# Classes

require_relative '../lib/search_request/car_request'
require_relative '../lib/create_table'
require_relative '../lib/search_operations/search_class'
require_relative '../lib/user/user'
# require_relative '../lib/user/create_account'
# require_relative '../lib/user/account_login'


require_relative '../lib/navigation/start_menu'
#include StartMenu
require_relative '../lib/translate_text'
include TranslateText
require_relative '../lib/search_operations/search_history'
include SearchHistory
require_relative '../lib/search_operations/result_table'
include ResultTable
require_relative '../lib/search_request/compare_requests'
include CompareRequests
require_relative '../lib/file_process'
include FileProcess

# config

require_relative '../config/initializers/i18n'
