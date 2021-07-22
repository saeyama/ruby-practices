#!/usr/bin/env ruby

score = ARGV[0]
scores = score.split(',')

shots = []
scores.each do |s|
  shots <<
    if s == 'X'
      10
    else
      s.to_i
    end
end

# 9フレーム目までになる要素を取得
change_frames = shots[0..-4]

first_frames = []
loop do
  first_frames <<
    if change_frames[0] == 10
      [change_frames.shift]
    else
      change_frames.shift(2)
    end
  break if change_frames[0].nil?
end

point_frames = first_frames + [shots[-3..-1]]

# 合計値
point = 0
point_frames.each_with_index do |frame, index|
  point +=
    if frame == [10] && point_frames[index + 1] == [10] && (index < 9)
      20 + point_frames[index + 2][0]
    elsif frame == [10] && (index < 9)
      10 + point_frames[index + 1][0] + point_frames[index + 1][1]
    elsif frame.sum == 10 && (index < 9)
      frame.sum + point_frames[index + 1][0]
    else
      frame.sum
    end
end

p point
