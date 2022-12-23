# frozen_string_literal: true

require_relative '../config/requirements'

# module for working with files
module FileProcess
  def update_content(file_name, content)
    file_exist(file_name)
    File.write(file_name, content.to_yaml)
  end

  def read_content(file_name)
    file_exist(file_name)
    YAML.load(File.read(file_name))
  end

  private

  def file_exist(file_name)
    File.new(file_name, 'w') unless File.exist?(file_name)
  end
end
