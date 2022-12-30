# frozen_string_literal: true


# class to create table
class BaseTable
  attr_accessor :table_title, :table_headings, :table_content

  def initialize(titles)
    @table_title = titles
  end

  def add_headings(headings)
    @table_headings = headings.to_a
  end

  def add_content(content_array)
    @table_content = []
    content_array.each { |car| @table_content << car.values }
  end

  def table_print
    table = Terminal::Table.new
    table.title = @table_title.colorize(:light_cyan)
    table.headings = @table_headings.map { |v| v.colorize(:blue) }
    table.rows = @table_content.map { |v| v.map { |val| val.to_s.colorize(:magenta) } }
    puts table
  end
end