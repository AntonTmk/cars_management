# frozen_string_literal: true

# module for creating tables from SearchResult
module Views
  module Table
    class CarsTable < BaseTable

      def title
        "   #{I18n.t('task_title')}
         #{I18n.t('total_quantity')}: #{@content[:total_quantity]}
         #{I18n.t('requests_quantity')}: #{@content[:requests_quantity]} ".colorize(:light_blue)
      end

      def headings
        %w[id make model year odometer price description date_added].map { |value| I18n.t(value).colorize(:blue) }
      end

      def rows
        @content[:content].map { |car| car.values.map { |param| param.to_s.colorize(:magenta) } }
      end
    end
  end
end
