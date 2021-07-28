#!/usr/bin/env ruby

score = ARGV[0]
scores = score.split(',')

shots =
  scores.map do |s|
    if s == 'X'
      10
    else
      s.to_i
    end
  end

frames =
  Array.new(10) do |i|
    if i < 9
      shots[0] == 10 ? [shots.shift] : shots.shift(2)
    else
      shots
    end
  end

# 合計値
point =
  frames.each_with_index.sum do |frame, index|
    if frame == [10] && frames[index + 1] == [10] && (index < 9)
      20 + frames[index + 2][0]
    elsif frame == [10] && (index < 9)
      10 + frames[index + 1][0] + frames[index + 1][1]
    elsif frame.sum == 10 && (index < 9)
      frame.sum + frames[index + 1][0]
    else
      frame.sum
    end
  end

p point
