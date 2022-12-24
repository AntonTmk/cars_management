# frozen_string_literal: true

require 'terminal-table'

module Views
  module Table
    class BaseTable
      def initialize(content)
        @content = content
      end

      def call
        Terminal::Table.new do |table|
          table.title = title
          table.headings = headings
          table.rows = rows
          table.style = style
        end
      end

      private

      attr_reader :data

      def title
        raise NotImplementedError, I18n.t('not_implemented', class: self.class, method: __method__)
      end

      def headings
        []
      end

      def rows
        raise NotImplementedError, I18n.t('not_implemented', class: self.class, method: __method__)
      end

      def style
        { all_separators: true }
      end
    end
  end
end
