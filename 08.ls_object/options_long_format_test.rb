#!/usr/bin/env ruby
# frozen_string_literal: true

require 'minitest/autorun'
require 'date'
require_relative 'options_long_format'

class OptionsLongFormatTest < Minitest::Test
  def setup
    @result = [['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 1177, '12 25 13:17', 'options_long_format.rb']]
  end

  def test_options_long1
    options_long_format = OptionsLongFormat.new(Dir.glob('options_long_format.rb').sort)
    assert_equal @result, options_long_format.list_directory
  end

  def test_options_long2
    options_long_format = OptionsLongFormat.new(Dir.glob('options_long_format.rb', File::FNM_DOTMATCH).sort)
    assert_equal @result, options_long_format.list_directory
  end

  def test_options_long3
    options_long_format = OptionsLongFormat.new(Dir.glob('options_long_format.rb').sort.reverse)
    assert_equal @result, options_long_format.list_directory
  end

  def test_options_long4
    options_long_format = OptionsLongFormat.new(Dir.glob('options_long_format.rb', File::FNM_DOTMATCH).sort.reverse)
    assert_equal @result, options_long_format.list_directory
  end
end
