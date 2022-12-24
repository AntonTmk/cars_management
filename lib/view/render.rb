require 'singleton'

module Views
  class Render
    include Singleton

    def render_table(table:, data:)
      puts table.new(data).call
    end

    def show_text(text:)
      puts text
    end

    def sociable(text: nil, secure: false)
      show_text(text:) if text
      secure ? $stdin.noecho(&:gets).chomp : gets.chomp
    end
  end
end
