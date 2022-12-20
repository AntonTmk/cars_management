# frozen_string_literal: true

require_relative '../user/user'

# module for navigating the application
class AuthorizationMenu
  attr_accessor :user

  def menu_login
    if @user.nil? || !@user.status
      @user = User.new
      print_item(5, 'Log_In')
      print_item(6, 'Sing_Up')
    else
      print_item(5, 'Log_Out')
    end
  end

  def print_item(num, i18n_text)
    puts "#{num}. #{I18n.t(i18n_text)}".colorize(:light_blue)
  end

  def select_event(event)
    case [event, @user.status]
    when ['5', true] then @user.log_out
    when ['5', false] then log_in_menu
    when ['6', false] then sing_up_menu
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
    @user.log_in(email, password)
  end

  def sing_up_menu
    puts I18n.t('"Sing_Up')
    puts I18n.t('input_email_please')
    email = gets.chomp
    puts I18n.t('input_password_please')
    password = gets.chomp
    @user.sing_up(email, password)
  end
end
