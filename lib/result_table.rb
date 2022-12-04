

require_relative '../lib/search_history'

module ResultTable

  def print_table(content, request)
    table = CreateTable.new(table_title(request))
    table.add_headings(table_heading)
    table.add_content(content)
    table.table_print
  end

  def table_title(request)
    "#{I18n.t('task_title')} \n
    #{I18n.t(:total_quantity)}: #{request.total_quantity}
    #{I18n.t(:requests_quantity)}:  #{request.requests_quantity}"
  end

  def table_heading
    %w[id make model year odometer price description date_added].map { |value| I18n.t(value) }
  end
end
