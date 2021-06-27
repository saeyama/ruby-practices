#! /usr/bin/env ruby

require 'optparse'
require 'date'

#コマンドオプション
params = ARGV.getopts("", "y:#{Date.today.year}", "m:#{Date.today.month}")

#指定年月
set_day = Date.new(params["y"].to_i,params["m"].to_i)

#月初と月末
firstday = Date.new(set_day.year, set_day.month, 1)
lastday = Date.new(set_day.year, set_day.month, -1)

#改行
line = firstday.wday - 1

#1行目/月と年
puts set_day.strftime("%-m月 %Y").center(22)

#2行目/曜日
week = "日 月 火 水 木 金 土"
print "#{week.rjust(14)}\n"
#3行目
print "   " * firstday.wday
(firstday..lastday).each do |day|
  line += 1
  if line % 7 == 0
    puts "\n"
  end
  print day.strftime("%-d").rjust(3)
end
puts "\n"
