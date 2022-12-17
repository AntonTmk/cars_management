
require_relative '../../config/requirements'


module AccountLogin
  include BCrypt
  attr_accessor :user

  def login_data_valid?(email, password)
    @user = User.new
    find_by_email(email)
    @user.status = if !@user.password_hash.nil? && @user.password_hash.is_password?(password)
                     puts "Hello, #{email}!".colorize(:green)
                     true
                   else
                     puts "Log In fail".colorize(:red)
                     false
                   end
    @user.status
  end

  private

  DB_USERS = 'users.yml'

  def find_by_email(email)
    hash = FileProcess.read_content(DB_USERS)
    unless hash.nil? || hash.empty?
      user = hash.find { |user| user[:email] == email }
      @user = User.new
      @user.email = email
      @user.password_hash = Password.new(user[:password])
    end
  end
end
