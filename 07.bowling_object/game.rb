#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(create_frames)
    shots = create_frames.split(',')
    frames =
      Array.new(10) do |i|
        if i < 9
          shots[0] == 'X' ? [shots.shift] : shots.shift(2)
        else
          shots
        end
      end
    @frames = frames.map { |frame| Frame.new(*frame) }
  end

  def point
    @frames.each_with_index.sum do |frame, index|
      if index < 9 && frame.strike?
        strike_calculation(frame, index)
      elsif index < 9 && frame.spare?
        frame.score + @frames[index + 1].shot1_score
      else
        frame.score
      end
    end
  end
end

private

def strike_calculation(frame, index)
  if index < 8 && frame.strike? && @frames[index + 1].strike?
    frame.score + @frames[index + 1].score + @frames[index + 2].shot1_score
  else
    frame.score + @frames[index + 1].shot1_and_shot2_score
  end
end
