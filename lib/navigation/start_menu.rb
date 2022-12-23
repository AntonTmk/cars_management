# frozen_string_literal: true

require_relative '../search_request/car_request'
require_relative '../search_operations/search_class'
require_relative 'authorization_menu'
require_relative '../search_operations/user_search_history/save_user_search_history'
require 'i18n'
require 'colorize'

# class for navigating the application
class StartMenu
  attr_accessor :autorization

  def initialize
    @authorization = AuthorizationMenu.new
  end

  def call
    print_item(1, 'Search_a_car')
    print_item(2, 'Show_all_cars')
    print_item(3, 'Help')
    print_item(4, 'Exit')
    @authorization.menu_login
    choose_menu
  end

  def print_item(num, i18n_key)
    puts "#{num}. #{I18n.t(i18n_key)}".colorize(:light_blue)
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
    when '5'..'6' then @authorization.select_event(event)
    else puts I18n.t('invalid_request').colorize(:black).on_red
    end
  end

  def search_car
    search_request = CarRequest.new
    search_request.print_menu
    search_result = SearchClass.new
    search_result.search_by_request(search_request)
    search_result.print_result
    save_request(search_result.request.id) if @authorization.user.status
  end

  def save_request(requests_id)
    history = SaveUserSearchHistory.new(@authorization.user.email)
    history.save_search_request(requests_id)
  end

  def all_cars
    search_request = CarRequest.new
    search_request.choose_sort
    search_result = SearchClass.new
    search_result.search_by_request(search_request)
    search_result.print_result
  end
end
