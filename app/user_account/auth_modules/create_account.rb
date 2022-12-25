# frozen_string_literal: true

# register data validator
module CreateAccount
  include FileProcess
  attr_accessor :errors

  EMAIL_REGEX = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/
  DB_USERS = 'data/users.yml'

  def sing_up?(user_data_object)
    @errors = []
    if email_validator?(user_data_object.email) && password_is_valid?(user_data_object.password_hash)
      puts "#{I18n.t('hello')}, #{user_data_object.email}!".colorize(:green)
      user_data_object.save!
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

  def find_by_email?(email)
    hash = read_content(DB_USERS)
    if !hash.nil? && !hash.empty?
      !hash.find { |user| user[:email] == email }.nil?
    else
      false
    end
  end
end
