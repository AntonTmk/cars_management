# frozen_string_literal: true

require 'i18n'
require 'colorize'
require 'date'
require 'bcrypt'
require 'yaml'

# classes

require './app/navigation/start_menu'

# modules

require './app/text_translation'

# config

require './config/initializers/i18n'

require './app/user_account/user_data'
require './app/user_account/user_auth'


require './app/search_request/car_request'
require './app/search_operations/search_class'
require './app/navigation/authorization_menu'

require './app/search_request/car_request'
require './app/search_operations/search_history'
require './app/view/table/cars_table'
require './app/file_process'
