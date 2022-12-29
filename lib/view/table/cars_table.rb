# frozen_string_literal: true

# module for creating tables from SearchResult
class CarsTable < BaseTable
  attr_accessor :table_title_data

  def initialize(content, search_request)
    super(content)
    @table_title_data = search_request
  end

  def title
    "#{I18n.t('task_title')} \n
    #{I18n.t(:total_quantity)}: #{@table_title_data.total_quantity}
    #{I18n.t(:requests_quantity)}:  #{@table_title_data.requests_quantity}"
  end

  def headings
    %w[id make model year odometer price description date_added].map { |value| I18n.t(value) }
  end

  def rows
    @content.map { |car| car = car.valuesa}
  end
end
