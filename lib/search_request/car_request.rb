# frozen_string_literal: true

require_relative '../../config/requirements'

# class for creating a search query
class CarRequest
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
    puts I18n.t('Please select search rules').colorize(:blue)
    @make = write_data('Please choose make')
    @model = write_data('Please choose model')
    @year_from = write_data('Please choose year_from').to_i
    @year_to = write_data('Please choose year_to').to_i
    @price_from = write_data('Please choose price_from').to_i
    @price_to = write_data('Please choose price_to').to_i
    choose_sort
  end

  def choose_sort
    @sort_option = write_data('Please choose sort option')
    @sort_direction = write_data('Please choose sort direction')
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

  def car_eql_nil?(var)
    text_check_nil?(self, var) && num_check_nil?(self, var)
  end

  def car_eql?(var)
    (downcase_array(compare_hash) - downcase_array(var)).empty?
  end

  private

  def compare_hash
    { make: @make, model: @model,
      year_from: @year_from, year_to: @year_to,
      price_from: @price_from, price_to: @price_to }
  end

  def downcase_array(hash)
    hash.values.map(&:to_s).map(&:downcase)
  end
end
