# frozen_string_literal: true

# module for working with files
module FileProcess
  def update_content(file_name, content)
    File.new(file_name, 'w') unless File.exist?(file_name)
    File.write(file_name, content.to_yaml)
  end

  def add_content(file_name, new_content)
    content = read_content(file_name)
    content.nil? ? content = [new_content] : content << new_content
    File.write(file_name, content.to_yaml)
  end

  def read_content(file_name)
    YAML.load(File.read(file_name)) if File.exist?(file_name)
  end
end
