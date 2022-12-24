# frozen_string_literal: true

require './config/requirements'

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
