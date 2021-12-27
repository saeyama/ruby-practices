#!/usr/bin/env ruby
# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'short_formatter'

class ShortFormatterTest < Minitest::Test
  def short_formatter(directory)
    ShortFormatter.new(directory)
  end

  def test_short_formatter1
    assert_equal [['long_formatter.rb', 'ls_command.rb', 'short_formatter_test.rb'],
                  ['long_formatter_test.rb', 'ls_command_test.rb', nil],
                  ['ls.rb', 'short_formatter.rb', nil]], short_formatter(Dir.glob('*').sort).list_directory
  end

  def test_short_formatter2
    assert_equal [['.', 'long_formatter_test.rb', 'short_formatter.rb'],
                  ['..', 'ls.rb', 'short_formatter_test.rb'],
                  ['.gitkeep', 'ls_command.rb', nil],
                  ['long_formatter.rb', 'ls_command_test.rb', nil]], short_formatter(Dir.glob('*', File::FNM_DOTMATCH).sort).list_directory
  end

  def test_short_formatter3
    assert_equal [['short_formatter_test.rb', 'ls_command.rb', 'long_formatter.rb'],
                  ['short_formatter.rb', 'ls.rb', nil],
                  ['ls_command_test.rb', 'long_formatter_test.rb', nil]], short_formatter(Dir.glob('*').sort.reverse).list_directory
  end

  def test_short_formatter4
    assert_equal [['short_formatter_test.rb', 'ls.rb', '..'],
                  ['short_formatter.rb', 'long_formatter_test.rb', '.'],
                  ['ls_command_test.rb', 'long_formatter.rb', nil],
                  ['ls_command.rb', '.gitkeep', nil]], short_formatter(Dir.glob('*', File::FNM_DOTMATCH).sort.reverse).list_directory
  end
end
