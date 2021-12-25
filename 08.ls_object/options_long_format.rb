# frozen_string_literal: true

require 'etc'

class OptionsLongFormat
  def initialize(files)
    @files = files
  end

  def list_directory
    puts "total #{total_stat_files}"
    create_row_files.each do |file|
      print file.join(' ')
      print "\n"
    end
  end

  private

  def create_stat_files
    @files.map { |file| File::Stat.new(file) }
  end

  def total_stat_files
    create_stat_files.sum(&:blocks)
  end

  def create_row_files
    create_stat_files.map.with_index do |fs, i|
      array = []
      array << filetype(fs.ftype)
      array << fs.mode.to_s(8)[-3, 3].chars.map { |f| permission(f.to_i) }.join('')
      array << fs.nlink.to_s
      array << Etc.getpwuid(fs.uid).name
      array << Etc.getgrgid(fs.gid).name
      array << fs.size
      array << fs.mtime.strftime('%-m %-d %H:%M')
      array << @files[i]
    end
  end

  def filetype(type)
    { 'fifo' => 'p', 'characterSpecial' => 'c', 'directory' => 'd', 'blockSpecial' => 'files', 'file' => '-', 'link' => 'l', 'socket' => 's' }[type]
  end

  def permission(type)
    { 0 => '---', 1 => '--x', 2 => '-w-', 3 => '-wx', 4 => 'r--', 5 => 'r-x', 6 => 'rw-', 7 => 'rwx' }[type]
  end
end
