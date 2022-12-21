# frozen_string_literal: true

require 'i18n'

# check if password valid
class PasswordValidator
  attr_accessor :password, :errors

  def initialize(password)
    @errors = []
    @password = password
  end

  def valid?
    password_errors_check
    @errors.empty?
  end

  def password_uppercase?
    check_value?(!@password.match(/\p{Upper}/).nil?, 'password_upcase_error')
  end

  def password_lower_case?
    check_value?(!@password.match(/\p{Lower}/).nil?, 'password_lowercase_error')
  end

  def password_special_char?
    special = "?<>',?[]}{=-)(*&^%$#`~{}!_@"
    regex = /[#{special.gsub(/./) { |char| "\\#{char}" }}]/
    check_value?(@password.scan(regex).length >= 2, 'password_special_character_error')
  end

  def password_contains_number?
    check_value?(@password.count('0-9').positive?, 'password_number_error')
  end

  def password_length?
    check_value?((8..20).include?(@password.length), 'password_long_error')
  end

  def check_value?(condition, i18n_error_key)
    if condition
      true
    else
      @errors << I18n.t(i18n_error_key).to_s
      false
    end
  end

  def password_errors_check
    password_uppercase?
    password_lower_case?
    password_contains_number?
    password_special_char?
    password_length?
  end
end
