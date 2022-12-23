# frozen_string_literal: true

require_relative '../config/requirements'

# module for working with files
module FileProcess
  def read_content(filename)
    file_exist(filename)
    YAML.load(File.read(filename))
  end

  def update_content(filename, content)
    File.write(filename, content.to_yaml)
  end

  private

  def file_exist(filename)
    File.new(filename, 'w') unless File.exist?(filename)
  end
end
