# frozen_string_literal: true

require_relative '../config/requirements'

# class for translating program content
module TranslateText

  def available_languages
    puts "Please choose locale  #{I18n.available_locales}".colorize(:light_blue)
    change_language
  end

  private

  def change_language
    language = gets.chomp
    I18n.locale = :uk if language.include? 'uk'
  end
end
