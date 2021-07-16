#!/usr/bin/env ruby

score = ARGV[0]
scores = score.split(',')

shots = []

scores.each do |s|
  case s
  when 'X'
    shots << 10
    shots << 0
  when 'S'
    shots << 10
  else
    shots << s.to_i
  end
end

first_frames = []
shots.each_slice(2) do |s|
  first_frames << s
end

# ストライク変更
change_frames = first_frames.map { |s| s == [10, 0] ? [10] : s }

# 10投目変更
point_frames =
  if change_frames.size == 12 && change_frames[8] == [10]
    change_frames[0..8].push(change_frames[-3] + change_frames[-2] + change_frames[-1])
  elsif change_frames.size == 11 && change_frames[9] == [10] && change_frames[8] == [10]
    change_frames[0..8].push(change_frames[-2] + change_frames[-1])
  elsif change_frames.size == 11 && change_frames[9][0] < 10 && change_frames[8] == [10]
    change_frames[0..8].push(change_frames[-2] + change_frames[-1])
  elsif change_frames.size == 10 && change_frames[8] == [10]
    change_frames[0..8].push(change_frames[-3] + change_frames[-2] + change_frames[-1])
  else
    change_frames
  end

# 合計値
point = 0

point_frames.each_with_index do |frame, index|
  point +=
    if frame == [10] && point_frames[index + 1] == [10] && point_frames[index + 2] == [10]
      30
    elsif frame == [10] && point_frames[index + 1] == [10] && (index < 9)
      20 + point_frames[index + 2][0]
    elsif frame[0] == 10 && (index < 9)
      10 + point_frames[index + 1][0] + point_frames[index + 1][1]
    elsif frame.sum == 10 && (index < 9)
      frame.sum + point_frames[index + 1][0]
    else
      frame.sum
    end
end

p point
