#!/usr/bin/env ruby
# frozen_string_literal: true

require './shot'

class Frame
  def initialize(shot)
    @shot_array = shot.score
  end

  def score_slice
    Array.new(10) do |i|
      if i < 9
        @shot_array[0] == 10 ? [@shot_array.shift] : @shot_array.shift(2)
      else
        @shot_array
      end
    end
  end
end
