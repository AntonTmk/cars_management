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
    @history_list = user_history_list.read_history
    user_history_exist? ? update_user_history : add_user_history
    update_content(USER_HISTORY_DB, history_list)
  end

  def user_history_exist?
    !@history_list.nil? && !@history_list.find { |history| history[:user_email] == @user_email }.nil?
  end

  def add_user_history
    @history_list = [] if @history_list.nil?
    @search_request.requests_quantity += 1
    @history_list << { user_email: @user_email, history: [@search_request.full_car_hash] }
  end

  def update_user_history
    @history_list.each do |user|
      update_history_request(user[:history]) if user[:user_email] == @user_email
    end
  end

  def update_history_request(users_history)
    if history_include_request?(users_history)
      history_increase_request(users_history)
    else
      users_history << @search_request.full_car_hash
    end
  end

  def history_increase_request(users_history)
    users_history.each { |request| request[:requests_quantity] += 1 if @search_request.car_eql?(request) }
  end

  def history_include_request?(history)
    !history.select { |request| @search_request.car_eql?(request) }.empty?
  end
end
