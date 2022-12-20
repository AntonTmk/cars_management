# frozen_string_literal: true

require_relative '../../config/requirements'
require_relative 'account_login'
require_relative 'create_account'
require_relative '../file_process'

# class for user
class User
  include BCrypt
  include CreateAccount
  include AccountLogin
  include FileProcess
  attr_accessor :email, :password_hash, :status

  DB_USERS = 'data/users.yml'.freeze

  def initialize
    @status = false
  end

  def password
    @password ||= Password.new(@password_hash)
  end

  def password=(new_password)
    @password_hash = Password.create(new_password)
  end

  def save!
    add_content(DB_USERS, { email: @email, password: @password_hash.to_s })
  end

  def log_in(email, password)
    add_data(email, password) if login_data_valid?(email, password)
  end

  def log_out
    @email = ""
    @password_hash = ""
    @status = false
  end

  def sing_up(email, password)
    if registration_attempt?(email, password)
      add_data(email, password)
      save!
    end
  end
  
  def add_data(email, password)
    @status = true
    @email = email
    @password_hash = Password.create(password)
  end
end
