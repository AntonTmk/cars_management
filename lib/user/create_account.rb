

require_relative 'password_validator'
require 'colorize'
require 'i18n'

# register data validator
module CreateAccount
  attr_accessor :errors
  EMAIL_REGEX = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/
  DB_USERS = 'data/users.yml'.freeze

  def registration_attempt?(email, password)
    @errors = []
    if email_validator?(email) && password_is_valid?(password)
      puts "#{I18n.t('hello')}, #{email}!".colorize(:green)
      true
    else
      @errors.each { |error| puts error.colorize(:red) }
      false
    end
  end

  private

  def email_validator?(email)
    @errors << I18n.t('used_email_error').to_s if find_by_email?(email)
    @errors << I18n.t('invalid_email').to_s unless email.match?(EMAIL_REGEX)
    email.match?(EMAIL_REGEX) && !find_by_email?(email)
  end

  def password_is_valid?(user_password)
    password = PasswordValidator.new(user_password)
    if password.valid?
      true
    else
      @errors += password.errors
      false
    end
  end

  private

  def find_by_email?(email)
    hash = FileProcess.read_content(DB_USERS)
    if !hash.nil? && !hash.empty?
      !hash.find { |user| user[:email] == email }.nil?
    else
      false
    end
  end
end
