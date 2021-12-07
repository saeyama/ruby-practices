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
    frames.map{ |frame| Frame.new(*frame) }
  end

  def point
    point =
    total_frames.each_with_index.sum do |frame,i|
      if frame.strike? && total_frames[i + 1] == 10 && (i < 9)
        20 + total_frames[i + 2].add_spare
      elsif frame.strike? && (i < 9)
        10 + total_frames[i + 1].add_strike
      elsif frame.spare? && (i < 9)
        frame.scores + total_frames[i + 1].add_spare
      else
        frame.scores
      end
    end
    point
  end
end
