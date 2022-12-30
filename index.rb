# frozen_string_literal: true

require_relative 'config/requirements'
include TextTranslation

TextTranslation.available_languages
puts I18n.t('Welcome').colorize(:black).on_blue
StartMenu.new.call
