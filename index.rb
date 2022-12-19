# frozen_string_literal: true

require_relative 'config/requirements'
# test
require_relative 'lib/user/password_validator'
password = PasswordValidator.new("15June_2001")
puts password.is_valid?
puts password.errors
# require_relative 'lib/advertisment_editor'
# editor = AdvertismentEditor.new
# editor.sellect_ad
# #editor.delete_car
# # editor.add_car
# editor.edit_car
# editor.save_changes
# test

TranslateText.available_languages
puts I18n.t('Welcome').colorize(:black).on_blue
menu = StartMenu.new
menu.call
