# frozen_string_literal: true

require_relative '../search_request/car_request'
require_relative '../search_operations/user_search_history/read_user_search_history'
require 'i18n'
require 'colorize'

# class for navigating the application
module UsersHistoryMenu
  def print_history_menu
    print_item(6, 'my_history')
  end

  def print_item(num, i18n_key)
    puts "#{num}. #{I18n.t(i18n_key)}".colorize(:light_blue)
  end

  def users_history(email)
    read_history = ReadUserSearchHistory.new(email)
    read_history.print_history_table
  end
end
