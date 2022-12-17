# frozen_string_literal: true

require_relative '../../config/requirements'
require_relative 'authorization_menu'

# module for navigating the application
class StartMenu
  attr_accessor :autorization

  def initialize
    @authorization = AuthorizationMenu.new
  end

  def call
    print_item(1, 'Search a car')
    print_item(2, 'Show all cars')
    print_item(3, 'Help')
    print_item(4, 'Exit')
    @authorization.menu_login
    choose_menu
  end

  def print_item(num, text)
    puts "#{num}. #{I18n.t(text)}".colorize(:light_blue)
  end

  def choose_menu
    puts I18n.t('Enter the menu item number').colorize(:blue).underline
    event = gets.chomp
    select_event(event)
    puts I18n.t('press ENTER button to return menu').colorize(:green)
    gets.chomp
    call
  end

  private

  def select_event(event)
    case event
    when '1' then search_car
    when '2' then all_cars
    when '3' then puts I18n.t('help message')
    when '4'
      puts I18n.t('goodbye').colorize(:black).on_blue
      exit
    when '5'.."6" then @authorization.select_event(event)
    else
        puts I18n.t('invalid request').colorize(:black).on_red
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
