#!/usr/bin/env ruby
# frozen_string_literal: true

require 'minitest/autorun'
require 'date'
require_relative 'long_formatter'

class LongFormatterTest < Minitest::Test
  def setup
    @result = [['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 1173, '12 27 19:39', 'long_formatter.rb']]
  end

  def test_long_formatter1
    long_formatter = LongFormatter.new(Dir.glob('long_formatter.rb').sort)
    assert_equal @result, long_formatter.list_directory
  end

  def test_long_formatter2
    long_formatter = LongFormatter.new(Dir.glob('long_formatter.rb', File::FNM_DOTMATCH).sort)
    assert_equal @result, long_formatter.list_directory
  end

  def test_long_formatter3
    long_formatter = LongFormatter.new(Dir.glob('long_formatter.rb').sort.reverse)
    assert_equal @result, long_formatter.list_directory
  end

  def test_long_formatter4
    long_formatter = LongFormatter.new(Dir.glob('long_formatter.rb', File::FNM_DOTMATCH).sort.reverse)
    assert_equal @result, long_formatter.list_directory
  end
end
