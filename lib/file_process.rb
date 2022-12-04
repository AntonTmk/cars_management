# frozen_string_literal: true

require_relative '../config/requirements'

# class for working with files
class FileProcess
  attr_accessor :file_name, :file_content

  def initialize(name)
    @file_name = name
    @file_content = read_content
  end

  def update_content
    File.write(@file_name, @file_content.to_yaml)
  end

  private

  def file_exist
    File.new(@file_name, 'w') unless File.exist?(@file_name)
  end

  def read_content
    file_exist
    YAML.load(File.read(@file_name))
  end
end