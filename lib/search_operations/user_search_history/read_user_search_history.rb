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
  HISTORY_DB = 'data/searches.yml'

  def initialize(email)
    @user_email = email
  end

  def read_history_from_db
    read_content(USER_HISTORY_DB)
  end

  def users_history_id_list
    read_history_from_db.select { |user| user[:user_email] == @user_email }[0][:history]
  end

  def print_history_table
    if !read_history_from_db.nil?
      print_table(read_history_by_id(users_history_id_list), @user_email)
    else
      puts I18n.t('no_history')
    end
  end

  def read_history_by_id(id_list)
    read_content(HISTORY_DB).select { |request| id_list.include?(request[:id]) }
  end
end
