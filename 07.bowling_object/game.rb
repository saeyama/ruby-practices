#!/usr/bin/env ruby
# frozen_string_literal: true

require './frame'

class Game
  def initialize(frame)
    @frames = frame.score_slice
  end

  def point
    @frames.each_with_index.sum do |f, i|
      if f == [10] && @frames[i + 1] == [10] && (i < 9)
        20 + @frames[i + 2][0]
      elsif f == [10] && (i < 9)
        10 + @frames[i + 1][0] + @frames[i + 1][1]
      elsif f.sum == 10 && (i < 9)
        f.sum + @frames[i + 1][0]
      else
        f.sum
      end
    end
  end

  def total
    [] << point
  end
end

game = Game.new(Frame.new(Shot.new))
p game.total
