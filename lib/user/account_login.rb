# frozen_string_literal: true

require 'i18n'
require 'bcrypt'
require_relative '../file_process'

# module for checking login parameters
module AccountLogin
  include BCrypt
  include FileProcess
  attr_accessor :user

  def login_data_valid?(email, password)
    @user = User.new
    find_by_email(email)
    @user.status = if !@user.password_hash.nil? && @user.password_hash.is_password?(password)
                     puts "#{I18n.t('hello')}, #{email}!".colorize(:green)
                     true
                   else
                     puts I18n.t('Log_In_fail').colorize(:red)
                     false
                   end
    @user.status
  end

  private

  DB_USERS = 'data/users.yml'

  def find_by_email(email)
    hash = read_content(DB_USERS)
    return if hash.nil? || hash.empty?

    user = hash.find { |users| users[:email] == email }
    @user = User.new
    @user.email = email
    @user.password_hash = Password.new(user[:password])
  end
end
