# frozen_string_literal: true

# class to create table
class BaseTable
  attr_accessor :content

  def initialize(content)
    @content = content
  end

  def call
    table = Terminal::Table.new
    table.title = title.colorize(:light_cyan)
    table.headings = headings.map { |v| v.colorize(:blue) }
    table.rows = rows.map { |v| v.map { |val| val.to_s.colorize(:magenta) } }
    puts table
  end


  def title
    raise NotImplementedError, I18n.t('table_output_error')
  end

  def headings
    []
  end

  def rows
    raise NotImplementedError, I18n.t('table_output_error')
  end
end
