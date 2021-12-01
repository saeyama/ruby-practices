#!/usr/bin/env ruby
# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'game'

class GameTest < Minitest::Test
  def test_game1
    game = Game.new(Frame.new(Shot.new('X,X,X,X,X,X,X,X,X,X,X,X')))
    assert_equal 300, game.point
  end

  def test_game2
    game = Game.new(Frame.new(Shot.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5')))
    assert_equal 139, game.point
  end
end
