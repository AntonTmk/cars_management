# frozen_string_literal: true

require './config/requirements'

# class for translating program content
module TextTranslation
  def available_languages
    puts "Please choose locale  #{I18n.available_locales}".colorize(:light_blue)
    change_language
  end

  private

  def change_language
    language = gets.chomp
    I18n.locale = I18n.available_locales.to_s.include?(language) ? language.to_sym : I18n.default_locale
  end
end
