# frozen_string_literal: true

require 'terminal-table'

# class to create table
class CreateTable
  attr_accessor :table_title, :table_headings, :table_content

  def initialize(titles)
    @table_title = titles
  end

  def add_headings(headings)
    @table_headings = headings.to_a
  end

  def add_content(val)
    @table_content = []
    val.each { |var| @table_content << var.values }
  end

  def table_print
    table = Terminal::Table.new
    table.title = @table_title
    table.headings = @table_headings
    table.rows = @table_content
    puts table
  end
end
