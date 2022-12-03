# frozen_string_literal: true

require 'i18n'

# class for translating program content
class TranslateText
  attr_accessor :translation_language

  def available_languages
    I18n.load_path += Dir[File.expand_path('config/locales') + '/*.yml']
    I18n.available_locales
  end

  def change_language(language)
    @translation_language = :en
    @translation_language = :ukr if language == 'ukr'
  end

  def translate_content(content)
    I18n.load_path += Dir[File.expand_path('config/locales') + '/*.yml']
    I18n.locale = translation_language
    I18n.t(content)
  end
end
