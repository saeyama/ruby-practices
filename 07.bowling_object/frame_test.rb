#!/usr/bin/env ruby
# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'frame'

class FrameTest < Minitest::Test
  def test_frame1
    frame = Frame.new('X')
    assert_equal 10, frame.scores
    assert frame.strike?
  end

  def test_frame2
    frame = Frame.new('1', '9')
    assert_equal 10, frame.scores
    assert frame.spare?
  end

  def test_frame3
    frame = Frame.new('X', 'X', 'X')
    assert_equal 30, frame.scores
  end
end
