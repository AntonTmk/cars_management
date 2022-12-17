# frozen_string_literal: true

require_relative '../search_request/car_request'
require_relative '../search_operations/search_class'
require 'i18n'
require 'colorize'

# module for navigating the application
module StartMenu

  def call
    print_item(1, 'Search_a_car')
    print_item(2, 'Show_all_cars')
    print_item(3, 'Help')
    print_item(4, 'Exit')
    choose_menu
  end

  def print_item(num, text)
    puts "#{num}. #{I18n.t(text)}".colorize(:light_blue)
  end

  def choose_menu
    puts I18n.t('Enter_the_menu_item_number').colorize(:blue).underline
    event = gets.chomp
    select_event(event)
    puts I18n.t('press_ENTER_button_to_return_menu').colorize(:green)
    gets.chomp
    call
  end

  private

  def select_event(event)
    case event
    when '1' then search_car
    when '2' then all_cars
    when '3' then puts I18n.t('help_message')
    when '4'
      puts I18n.t('goodbye').colorize(:black).on_blue
      exit
    else puts I18n.t('invalid_request').colorize(:black).on_red
    end
  end

  def search_car
    search_request = CarRequest.new
    search_request.print_menu
    search_result = SearchClass.new(search_request)
    search_result.print_result
  end

  def all_cars
    search_request = CarRequest.new
    search_request.choose_sort
    search_result = SearchClass.new(search_request)
    search_result.print_result
  end
end
