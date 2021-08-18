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
  else
    files_sizes($stdin.read).map { |file| print file.to_s.ljust(4) }
    print "\n"
  end
end

# 行数/単語数/バイト数出力用
def files_sizes(file_content)
  [file_content.lines.count, file_content.split(/\s+/).size, file_content.bytesize]
end

# ファイル名出力用
def files_content(files)
  files.map do |file|
    file_content = File.read(file)
    files_sizes(file_content) + [file.to_s]
  end.transpose
end

# wcコマンド(各内容の出力結果)
def files_content_each(numbers)
  numbers.transpose.each do |file|
    print file.join(' ').to_s
    print "\n"
  end
end

# wcコマンド(2以上だった場合の各内容とトータルの出力結果)
def files_content_total(numbers, total)
  files_content_each(numbers)
  print total
  print "\n"
end

# wcコマンド -lオプション
def wc_opton_l(files)
  numbers = [files_content(files)[0].map(&:to_s)] + [files_content(files)[3]]
  total = "#{files_content(files)[0].sum} total"
  files.size == 1 ? files_content_each(numbers) : files_content_total(numbers, total)
end

# wcコマンド ファイル指定
def wc_files(files)
  numbers = files_content(files)
  total = "#{files_content(files)[0..2].map(&:sum).join(' ')} total"
  files.size == 1 ? files_content_each(numbers) : files_content_total(numbers, total)
end

main
