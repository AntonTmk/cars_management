# frozen_string_literal: true

require_relative '../../file_process'
require_relative '../../search_request/car_request'
require_relative 'read_user_search_history'

# class for saving users search requests
class SaveUserSearchHistory
  attr_accessor :user_email, :history_list, :search_request

  include FileProcess

  USER_HISTORY_DB = 'data/user_history.yml'

  def initialize(email)
    @user_email = email
  end

  def save_search_request(search_request)
    @search_request = search_request
    user_history_list = ReadUserSearchHistory.new(@user_email)
    @history_list = user_history_list.read_history_from_db
    users_history_exist? ? update_users_history : add_new_users_history
    update_content(USER_HISTORY_DB, history_list)
  end

  def users_history_exist?
    !@history_list.nil? && !@history_list.find { |history| history[:user_email] == @user_email }.nil?
  end

  def add_new_users_history
    @history_list = [] if @history_list.nil?
    @search_request.requests_quantity = 1
    @history_list << { user_email: @user_email, history: [@search_request.id] }
  end

  def update_users_history
    @history_list.each do |user|
      update_history_request(user[:history]) if user[:user_email] == @user_email
    end
  end

  def update_history_request(users_history)
    unless users_history.include?(@search_request.id)
      users_history << @search_request.id
    end
  end
end
