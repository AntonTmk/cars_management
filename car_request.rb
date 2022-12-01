# frozen_string_literal: true

# class for creating a search query
class CarRequest
  attr_accessor :make, :model, :year_from, :year_to, :price_from, :price_to, :sort_option, :sort_direction,
                :requests_quantity, :total_quantity

  def initialize
    puts 'Please select search rules'
    @make = write_data('Please choose make:')
    @model = write_data('Please choose model:')
    @year_from = write_data('Please choose year_from:').to_i
    @year_to = write_data('Please choose year_to:').to_i
    @price_from = write_data('Please choose price_from:').to_i
    @price_to = write_data('Please choose price_to:').to_i
    @sort_option = write_data('Please choose sort option (date_added|price):')
    @sort_direction = write_data('Please choose sort direction(desc|asc):')
  end

  def write_data(message)
    puts message
    gets.chomp
  end

  def car_eql?(var)
    text_check?(var) && num_check?(var)
  end

  def text_check?(var)
    text_eql?(@make, var['make']) and text_eql?(@model, var['model'])
  end

  def num_check?(var)
    num_range?(@year_from, @year_to, var['year']) and num_range?(@price_from, @price_to, var['price'])
  end

  def text_eql?(var1, var2)
    var1.empty? || var1.casecmp(var2).zero?
  end

  def num_range?(min, max, var)
    min.zero? || var >= min and max.zero? || var <= max
  end

  def car_hash(val1, val2)
    { make: @make, model: @model,
      year_from: @year_from, year_to: @year_to,
      price_from: @price_from, price_to: @price_to,
      requests_quantity: val1, total_quantity: val2 }
  end
end