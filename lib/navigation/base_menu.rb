# frozen_string_literal: true

# class for navigating the application
class BaseMenu
  def print_item(num, i18n_key)
    puts "#{num}. #{I18n.t(i18n_key)}".colorize(:light_blue)
  end

  def select_event(event); end
end
