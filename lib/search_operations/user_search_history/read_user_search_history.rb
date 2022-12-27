# frozen_string_literal: true

# class for read users search history
class ReadUserSearchHistory
  attr_accessor :user_email

  include FileProcess

  USER_HISTORY_DB = 'data/user_history.yml'
  HISTORY_DB = 'data/searches.yml'

  def initialize(email)
    @user_email = email
  end

  def read_history_from_db
    read_content(USER_HISTORY_DB)
  end

  def users_history_list
    users_history = read_history_from_db.select { |user| user[:user_email] == @user_email }[0]
    users_history.nil? ? nil : users_history[:history]
  end

  def print_history_table
    if !read_history_from_db.nil? && !users_history_list.nil?
      Views::Render.instance.render_table(table: Views::Table::UserHistoryTable,
                                          data: { email: @user_email, content: read_users_history })
    else
      puts I18n.t('no_history')
    end
  end

  def read_users_history
    users_history_list = users_history_requests_list
    users_history_list.map { |request| request[:requests_quantity] = get_requests_quantity_by_id(users_history_list, request[:id]) }
    users_history_list
  end

  def users_history_requests_list
    read_content(HISTORY_DB).select { |request| requests_id_list(users_history_list).include?(request[:id]) }
  end

  def requests_id_list(requests_list)
    requests_list.map { |request| request = request[:id] }
  end

  def get_requests_quantity_by_id(requests_list, id)
    requests_list.select { |request| request[:id] == id }[0][:requests_quantity]
  end
end
