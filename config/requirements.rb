# frozen_string_literal: true

require 'i18n'
require 'colorize'
require 'date'
require 'bcrypt'
require 'yaml'
require 'terminal-table'

# classes/modules

require './app/view/table/base_table'
require './app/navigation/start_menu'
require './app/file_process'
require './app/search_operations/search_history'
require './app/view/table/cars_table'
require './app/search_operations/search_class'
require './app/text_translation'
require './config/initializers/i18n'
require './app/user_account/auth_modules/account_login'
require './app/user_account/auth_modules/log_out'
require './app/user_account/auth_modules/create_account'
require './app/user_account/user_data'
require './app/user_account/user_auth'
require './app/search_request/comparison_requests'
require './app/search_request/car_request'
require './app/navigation/authorization_menu'
