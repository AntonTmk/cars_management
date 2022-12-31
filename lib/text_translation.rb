# frozen_string_literal: true

# class for translating program content
module TextTranslation
  def available_languages
    puts "Please choose locale  #{I18n.available_locales}".colorize(:light_blue)
    change_language
  end

  private

  def include_language?(language)
    !language_from_list(language).nil? && !language_from_list(language).empty?
  end

  def language_from_list(language)
    I18n.available_locales.select { |lang| language.match?(lang.to_s) }[0]
  end

  def change_language
    language = gets.chomp
    I18n.locale = include_language?(language) ? language_from_list(language) : I18n.default_locale
  end
end
