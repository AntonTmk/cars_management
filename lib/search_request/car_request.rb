# frozen_string_literal: true

require 'i18n'
require 'colorize'
require_relative 'comparison_requests'

# class for creating a search query
class CarRequest
  include ComparisonRequests
  attr_accessor :make, :model, :year_from, :year_to, :price_from, :price_to, :sort_option, :sort_direction,
                :requests_quantity, :total_quantity

  def initialize
    @make = ''
    @model = ''
    @year_from = 0
    @year_to = 0
    @price_from = 0
    @price_to = 0
    @sort_option = ''
    @sort_direction = ''
  end

  def print_menu
    puts I18n.t('Please_select_search_rules').colorize(:blue)
    @make = write_data('Please_choose_make')
    @model = write_data('Please_choose_model')
    @year_from = write_data('Please_choose_year_from').to_i
    @year_to = write_data('Please_choose_year_to').to_i
    @price_from = write_data('Please_choose_price_from').to_i
    @price_to = write_data('Please_choose_price_to').to_i
    choose_sort
  end

  def choose_sort
    @sort_option = write_data('Please_choose_sort_option')
    @sort_direction = write_data('Please_choose_sort_direction')
  end

  def write_data(message)
    puts I18n.t(message).colorize(:cyan)
    gets.chomp
  end

  def car_hash(val1, val2)
    { make: @make, model: @model,
      year_from: @year_from, year_to: @year_to,
      price_from: @price_from, price_to: @price_to,
      requests_quantity: val1, total_quantity: val2 }
  end

  def include?(hash)
    text_eql_or_nil?(self, hash) && num_eql_or_nil?(self, hash)
  end

  def car_eql?(hash)
    downcase_array(hash) == downcase_array(car_hash(hash[:requests_quantity], hash[:total_quantity]))
  end

  private

  def downcase_array(hash)
    hash.values.map(&:to_s).map(&:downcase)
  end
end
