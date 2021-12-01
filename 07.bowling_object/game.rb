#!/usr/bin/env ruby
# frozen_string_literal: true

require './frame'

class Game
  def initialize(frames)
    @frames = frames.score_slice
  end

  def strike_calculation(frame, index)
    if frame == [10] && @frames[index + 1] == [10] && (index < 9)
      20 + @frames[index + 2][0]
    elsif frame == [10] && (index < 9)
      10 + @frames[index + 1][0] + @frames[index + 1][1]
    end
  end

  def point
    @frames.each_with_index.sum do |frame, index|
      if frame == [10]
        strike_calculation(frame, index)
      elsif frame.sum == 10 && (index < 9)
        frame.sum + @frames[index + 1][0]
      else
        frame.sum
      end
    end
  end
end

game = Game.new(Frame.new(Shot.new(ARGV[0])))
p game.point
