# frozen_string_literal: true

require 'i18n'
require 'bcrypt'
require_relative '../../file_process'

# module for checking login parameters
module AccountLogin
  include BCrypt
  include FileProcess
  attr_accessor :user

  def log_in(user_data_object)
    db_include_email(user_data_object.email)
    if !@user.password_hash.nil? && @user.password_hash.is_password?(user_data_object.password_hash)
      puts "#{I18n.t('hello')}, #{user_data_object.email}!".colorize(:green)
      @user.status = true
    else
      puts I18n.t('Log_In_fail').colorize(:red)
    end
    @user
  end

  private

  DB_USERS = 'data/users.yml'

  def db_include_email(email)
    hash = read_content(DB_USERS)
    return if hash.nil? || hash.empty?

    user = hash.find { |users| users[:email] == email }
    @user = user.nil? ? UserData.new(nil, nil) : UserData.new(email, Password.new(user[:password]))
  end
end
