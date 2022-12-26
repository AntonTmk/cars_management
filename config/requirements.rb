# frozen_string_literal: true

# gems

require 'i18n'
require 'colorize'
require 'bcrypt'
require 'terminal-table'
require 'yaml'
require 'date'

# classes
require './lib/file_process'

require_relative '../lib/navigation/start_menu'
require_relative '../lib/text_translation'


require_relative '../config/initializers/i18n'

# tables

require './lib/view/render'
require './lib/view/table/base_table'
require './lib/view/table/cars_table'
require './lib/view/table/user_history_table'

# user authorization

require './lib/user_account/user_data'
require './lib/user_account/auth_modules/account_login'
require './lib/user_account/auth_modules/log_out'
require './lib/user_account/auth_modules/create_account'
require './lib/user_account/user_auth'
require './lib/user_account/password_validator'

require './lib/search_request/comparison_requests'
require './lib/search_request/car_request'
require './lib/search_operations/search_history'
require './lib/search_operations/car_search'
require './lib/search_operations/user_search_history/save_user_search_history'
require './lib/search_operations/user_search_history/read_user_search_history'

require './lib/navigation/user_history_menu'
require './lib/navigation/authorization_menu'
