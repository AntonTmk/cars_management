# frozen_string_literal: true

# class for navigating the application
class UsersHistoryMenu < BaseMenu
  def call
    print_item(6, 'my_history')
  end

  def users_history(email)
    read_history = ReadUserSearchHistory.new(email)
    read_history.print_history_table
  end
end
