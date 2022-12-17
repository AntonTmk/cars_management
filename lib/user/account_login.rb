
require_relative '../../config/requirements'


module AccountLogin
  include BCrypt
  attr_accessor :user

  def login_menu
    @user = User.new
    puts "Login to account"
    puts "input email please:"
    email = gets.chomp
    puts "input password please:"
    password = gets.chomp
    login(email, password)
    {status: @user.status, email: @user.email, password: password}
  end

  def login(email, password)
    find_by_email(email)
    @user.status = if !@user.password_hash.nil? && @user.password_hash.is_password?(password)
                     puts "Hello, #{email}!".colorize(:green)
                     true
                   else
                     puts "Log In fail".colorize(:red)
                     false
                   end
  end

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
