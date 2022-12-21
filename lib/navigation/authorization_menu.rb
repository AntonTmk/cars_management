# frozen_string_literal: true

require_relative '../user_account/user_data'
require_relative '../user_account/user_auth'
require_relative 'user_history_menu'

# module for navigating the application
class AuthorizationMenu
  attr_accessor :user

  include UserAuth
  include UsersHistoryMenu

  def initialize
    @user = UserData.new('email', 'password')
  end

  def menu_login
    if @user.nil? || !@user.status
      print_item(5, 'Log_In')
      print_item(6, 'Sing_Up')
    else
      print_item(5, 'Log_Out')
      print_history_menu
    end
  end

  def print_item(num, i18n_text)
    puts "#{num}. #{I18n.t(i18n_text)}".colorize(:light_blue)
  end

  def select_event(event)
    case [event, @user.status]
    when ['5', true] then @user = UserAuth.log_out(@user)
    when ['5', false] then log_in_menu
    when ['6', false] then sing_up_menu
    when ['6', true] then users_history(@user.email)
    else
      puts I18n.t('invalid_request').colorize(:black).on_red
    end
  end

  def log_in_menu
    puts I18n.t('Login_to_account')
    puts I18n.t('input_email_please')
    email = gets.chomp
    puts I18n.t('input_password_please')
    password = gets.chomp
    @user = UserData.new(email, password)
    @user = UserAuth.log_in(@user)
  end

  def sing_up_menu
    puts I18n.t('Sing_Up')
    puts I18n.t('input_email_please')
    email = gets.chomp
    puts I18n.t('input_password_please')
    password = gets.chomp
    @user = UserData.new(email, password)
    @user.status = UserAuth.sing_up?(@user)
  end
end
