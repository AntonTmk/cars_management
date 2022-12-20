# frozen_string_literal: true

require_relative 'config/requirements'

TranslateText.available_languages
puts I18n.t('Welcome').colorize(:black).on_blue
menu = StartMenu.new
menu.call
