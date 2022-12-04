# frozen_string_literal: true

require_relative 'translate_text'
require 'colorize'

# class for creating a search query
class CarRequest
  attr_accessor :make, :model, :year_from, :year_to, :price_from, :price_to, :sort_option, :sort_direction,
                :requests_quantity, :total_quantity, :translator

  def initialize
    choose_language
    puts @translator.translate_content('Please select search rules').colorize(:blue)
    @make = write_data('Please choose make')
    @model = write_data('Please choose model')
    @year_from = write_data('Please choose year_from').to_i
    @year_to = write_data('Please choose year_to').to_i
    @price_from = write_data('Please choose price_from').to_i
    @price_to = write_data('Please choose price_to').to_i
    choose_sort
  end

  def choose_language
    @translator = TranslateText.new
    puts "Please choose locale  #{@translator.available_languages}".colorize(:light_blue)
    @translator.change_language(gets.chomp)
  end

  def choose_sort
    @sort_option = write_data('Please choose sort option')
    @sort_direction = write_data('Please choose sort direction')
  end

  def write_data(message)
    puts @translator.translate_content(message).colorize(:cyan)
    gets.chomp
  end

  def car_hash(val1, val2)
    { make: @make, model: @model,
      year_from: @year_from, year_to: @year_to,
      price_from: @price_from, price_to: @price_to,
      requests_quantity: val1, total_quantity: val2 }
  end

  def car_eql?(var)
    text_check?(var) and num_check?(var)
  end

  def car_eql_nil?(var)
    text_check_nil?(var) && num_check_nil?(var)
  end

  private

  #eql
  def text_check?(var)
    text_eql?(@make, var[:make].to_s) and text_eql?(@model, var[:model])
  end

  def num_check?(var)
    num_eql?(@year_from, var[:year_from]) and num_eql?(@year_to, var[:year_to]) and
      num_eql?(@price_from, var[:price_from]) and num_eql?(@price_to, var[:price_to])
  end

  def text_eql?(var1, var2)
    #print "first" + var1.to_s
    #     print var1.to_s.casecmp(var2.to_s).zero?
    #     print "Seccond " + var2.to_s
    #     puts
      var1.to_s.casecmp(var2.to_s).zero?
  end

  def num_eql?(var1, var2)
    # print var1.to_i
    #     print var1.to_i == var2.to_i
    #     print var2.to_i
    #     puts
    var1.to_i == var2.to_i
  end

  #include
  def text_check_nil?(var)
    text_include?(@make, var['make']) || text_include?(@make, var['make']) == nil and
      text_include?(@model, var['model']) || text_include?(@model, var['model']) == nil
  end

  def num_check_nil?(var)
    num_range_nul?(@year_from, @year_to, var['year']) || num_range_nul?(@year_from, @year_to, var['year']) == nil and
      num_range_nul?(@price_from, @price_to, var['price']) || num_range_nul?(@price_from, @price_to, var['price']) == nil
  end

  def text_include?(var1, var2)
    var1.empty? || var1.casecmp(var2.to_s).zero?
  end

  def num_range_nul?(min, max, var)
    min.zero? || var >= min and max.zero? || var <= max
  end
  ##

end
