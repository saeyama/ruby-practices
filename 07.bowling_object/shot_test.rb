#!/usr/bin/env ruby
# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'shot'

class ShotTest < Minitest::Test
  def test_score1
    shot = Shot.new('X,X,X,X,X,X,X,X,X,X,X,X')
    assert_equal [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10], shot.score
  end

  def test_score2
    shot = Shot.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5')
    assert_equal [6, 3, 9, 0, 0, 3, 8, 2, 7, 3, 10, 9, 1, 8, 0, 10, 6, 4, 5], shot.score
  end
end
