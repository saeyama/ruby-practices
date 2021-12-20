#!/usr/bin/env ruby
# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'shot'

class ShotTest < Minitest::Test
  def test_score1
    shot = Shot.new('X')
    assert_equal 10, shot.score
  end

  def test_score2
    shot = Shot.new('6')
    assert_equal 6, shot.score
  end
end
