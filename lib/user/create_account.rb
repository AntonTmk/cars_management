
# require_relative '../../config/requirements'
require_relative 'password_validator'
require 'colorize'

# register
module CreateAccount
  EMAIL_REGEX = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/
  DB_USERS = 'users.yml'

  def registration_attempt?(email, password)
    if email_validator?(email) && password_is_valid(password)
      puts "Hello, #{email}!"
      true
    else
      puts 'Invalid email or password'.colorize(:red)
      false
    end
  end

  def email_validator?(email)
    email.match?(EMAIL_REGEX) && !find_by_email?(email)
  end

  def password_is_valid(user_password)
    password = PasswordValidator.new(user_password)
    password.is_valid?
  end

  private

  def find_by_email?(email)
    hash = FileProcess.read_content(DB_USERS)
    unless hash.nil? || hash.empty?
      hash.find { |user| user[:email] == email }.nil? ? false : true
    else
      false
    end
  end
end
