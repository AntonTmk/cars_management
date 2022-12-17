# frozen_string_literal: true

require_relative '../../config/requirements'

# module for navigating the application
class AuthorizationMenu
  attr_accessor :user

  def menu_login
    if @user.nil? || !@user.status
      @user = User.new
      print_item(5, 'Log In')
      print_item(6, 'Sing Up')
    else
      print_item(5, 'Log Out')
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
      puts I18n.t('invalid request').colorize(:black).on_red
    end
  end

  def log_in_menu
      puts "Login to account"
      puts "input email please:"
      email = gets.chomp
      puts "input password please:"
      password = gets.chomp
      @user.log_in(email, password)
  end

  def sing_up_menu
    puts "Create account"
    puts "input email please:"
    email = gets.chomp
    puts "input password please:"
    password = gets.chomp
    @user.sing_up(email, password)
  end
end

