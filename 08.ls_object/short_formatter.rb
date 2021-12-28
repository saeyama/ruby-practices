# frozen_string_literal: true

class ShortFormatter
  def initialize(files)
    @files = files
  end

  def list_directory
    split_list_directory.transpose.each do |split_file|
      split_file.each { |file| print file.to_s.ljust(24) }
      print "\n"
    end
  end

  private

  COLUMNS_NUMBER = 3

  def create_list_directory
    column_files = []
    @files.each_slice(COLUMNS_NUMBER) do |list|
      column_files << list
    end

    column_files.map do |file|
      file.values_at(0...COLUMNS_NUMBER)
    end.flatten
  end

  def split_list_directory
    create_list_directory.each_slice(create_list_directory.size / COLUMNS_NUMBER).to_a
  end
end
