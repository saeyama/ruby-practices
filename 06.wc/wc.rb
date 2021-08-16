#!/usr/bin/env ruby
require 'optparse'

def main
  option = ARGV.getopts('l')
  files = ARGV
  # wcコマンド -lオプション
  if option['l'] && files.size >= 1
    wc_opton_l(files)
  # wcコマンド file指定
  elsif files.size >= 1
    wc_files(files)
  # $stdin.read
  elsif files.empty?
    list_directory_count
  end
end

# 行数/単語数/バイト数/ファイル名
def files_content(files)
  files.map do |file|
    [File.read(file).lines.count, 
      File.read(file).split(/\s+/).size, 
      File.read(file).bytesize, file.to_s]
  end.transpose
end

# wcコマンド(ファイル指定/-lオプション) 出力結果用
def files_content_export(files, numbers, files_content_total)
  if files.size == 1
    numbers.transpose.each do |file|
      print file.join(' ').to_s
      print "\n"
    end
  elsif files.size >= 2
    numbers.transpose.each do |file|
      print file.join(' ').to_s
      print "\n"
    end
    print files_content_total
    print "\n"
  end
end

# wcコマンド -lオプション
def wc_opton_l(files)
  files_content_export(files, 
                       ([files_content(files)[0].map(&:to_s)] + [files_content(files)[3]]), 
                       "#{files_content(files)[0].sum} total")
end

# wcコマンド ファイル指定
def wc_files(files)
  files_content_export(files, 
                       files_content(files), 
                      "#{files_content(files)[0..2].map(&:sum).join(' ')} total")
end

# $stdin.read
def list_directory_count
  list_directory = $stdin.read
  [list_directory.count("\n"),
   list_directory.split(/\s+/).size,
   list_directory.bytesize].map { |file| print file.to_s.ljust(4) }
  print "\n"
end

main
