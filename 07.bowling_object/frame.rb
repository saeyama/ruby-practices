#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'shot'

class Frame
  def initialize(shot1, shot2 = nil, shot3 = nil)
    @shot1 = Shot.new(shot1)
    @shot2 = Shot.new(shot2)
    @shot3 = Shot.new(shot3)
  end

  def shot1_and_shot2_score
    [@shot1.score, @shot2.score].sum
  end

  def shot1_score
    @shot1.score
  end

  def score
    [@shot1.score, @shot2.score, @shot3.score].sum
  end

  def strike?
    @shot1.score == 10
  end

  def spare?
    [@shot1.score, @shot2.score].sum == 10 && !strike?
  end
end
