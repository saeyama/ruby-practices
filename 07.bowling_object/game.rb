#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'

class Game
  def initialize(input)
    @input = input
  end

  def total_frames
    shots = @input.split(',')
    frames =
      Array.new(10) do |i|
        if i < 9
          shots[0] == 'X' ? [shots.shift] : shots.shift(2)
        else
          shots
        end
      end
    frames.map { |frame| Frame.new(*frame) }
  end

  def strike_calculation(frame, index)
    if index < 8 && frame.strike? && total_frames[index + 1].strike?
      20 + total_frames[index + 2].add_1score
    elsif index < 9 && frame.strike?
      10 + total_frames[index + 1].add_2score
    end
  end

  def point
    total_frames.each_with_index.sum do |frame, index|
      if index < 9 && frame.strike?
        strike_calculation(frame, index)
      elsif index < 9 && frame.spare?
        frame.scores + total_frames[index + 1].add_1score
      else
        frame.scores
      end
    end
  end
end
