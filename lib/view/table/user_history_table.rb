# frozen_string_literal: true

require_relative 'base_table'

# module for creating tables from Users history
module UserHistoryTable
  def print_table(content, email)
    table = BaseTable.new(table_title(email))
    table.add_headings(table_heading)
    table.add_content(content)
    table.table_print
  end

  def table_title(email)
    "#{I18n.t('task_title')} \n #{email}"
  end

  def table_heading
    %w[make model year_from year_to price_from price_to requests_quantity total_quantity].map { |value| I18n.t(value) }
  end
end
