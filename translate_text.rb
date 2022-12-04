# frozen_string_literal: true

require_relative 'locale_config.rb'
include LocaleConfig
require 'i18n'

# class for translating program content
class TranslateText
  attr_accessor :translation_language

  def available_languages
    I18n.load_path += init
    I18n.available_locales
  end

  def change_language(language)
    @translation_language = 'en'
    @translation_language = :uk if language.include? 'uk'
  end

  def translate_content(content)
    I18n.load_path += init
    I18n.locale = translation_language
    I18n.t(content)
  end
end
