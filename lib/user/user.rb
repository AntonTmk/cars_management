# frozen_string_literal: true

require_relative '../../config/requirements'

# class for user
class User
  # users.password_hash in the database is a :string
  include BCrypt

  attr_accessor :email, :password_hash, :status

  DB_USERS = 'users.yml'

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
    FileProcess.add_content(DB_USERS, { email: @email, password: @password_hash.to_s })
  end

  def log_in
    hash_init(login_menu)
  end

  def log_out
    @email = ""
    @password_hash = ""
    @status = false
  end

  def sing_up
    hash_init(sing_up_menu)
  end

  def hash_init(user)
    @email = user[:email]
    @password_hash = user[:password]
    @status = user[:status]
  end
end
