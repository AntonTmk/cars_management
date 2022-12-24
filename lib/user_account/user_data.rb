# frozen_string_literal: true

require './config/requirements'
require './lib/file_process'

# class for user_account
class UserData
  include BCrypt
  include FileProcess
  attr_accessor :email, :password_hash, :status

  def initialize(email, password)
    @status = false
    @email = email
    @password_hash = password
  end

  DB_USERS = 'data/users.yml'

  def save!
    add_content(DB_USERS, { email: @email, password: Password.create(@password_hash).to_s })
  end
end
