# frozen_string_literal: true

require_relative '../../file_process'
require_relative '../../view/table/user_history_table'
require 'i18n'

# class for read users search history
class ReadUserSearchHistory
  attr_accessor :user_email

  include FileProcess
  include UserHistoryTable

  USER_HISTORY_DB = 'data/user_history.yml'

  def initialize(email)
    @user_email = email
  end

  def read_history_from_db
    read_content(USER_HISTORY_DB)
  end

  def read_users_history
    read_history_from_db.select { |user| user[:user_email] == @user_email }[0]
  end

  def print_history_table
    if !read_users_history.nil?
      print_table(read_users_history[:history], @user_email)
    else
      puts I18n.t('no_history')
    end
  end
end
