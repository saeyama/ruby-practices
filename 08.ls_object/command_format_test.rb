#!/usr/bin/env ruby
# frozen_string_literal: true

require 'minitest/autorun'
require 'date'
require_relative 'command_format'

class CommandFormatTest < Minitest::Test
  def command_option(format)
    CommandFormat.new(format)
  end

  def test_command1
    assert_equal [['command_format.rb', 'options.rb', 'options_test.rb'],
                  ['command_format_test.rb', 'options_long_format.rb', nil],
                  ['ls.rb', 'options_long_format_test.rb', nil]], command_option(' ').list_directory
  end

  def test_command2
    assert_equal [['.', 'command_format_test.rb', 'options_long_format_test.rb'],
                  ['..', 'ls.rb', 'options_test.rb'], ['.gitkeep', 'options.rb', nil],
                  ['command_format.rb', 'options_long_format.rb', nil]], command_option('a').list_directory
  end

  def test_command3
    assert_equal [['options_test.rb', 'options.rb', 'command_format.rb'],
                  ['options_long_format_test.rb', 'ls.rb', nil],
                  ['options_long_format.rb', 'command_format_test.rb', nil]], command_option('r').list_directory
  end

  def test_command4
    assert_equal [['options_test.rb', 'ls.rb', '..'],
                  ['options_long_format_test.rb', 'command_format_test.rb', '.'],
                  ['options_long_format.rb', 'command_format.rb', nil],
                  ['options.rb', '.gitkeep', nil]], command_option('ar').list_directory
  end

  def test_command5
    assert_equal [['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 601, '12 26 18:25', 'command_format.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 3390, Time.new.strftime('%m %d %H:%M'), 'command_format_test.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 183, '12 26 18:25', 'ls.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 672, '12 26 15:19', 'options.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 1177, '12 25 13:17', 'options_long_format.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 1095, '12 26 15:29', 'options_long_format_test.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 1493, '12 26 15:29', 'options_test.rb']], command_option('l').list_directory
  end

  def test_command6
    assert_equal [['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 1493, '12 26 15:29', 'options_test.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 1095, '12 26 15:29', 'options_long_format_test.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 1177, '12 25 13:17', 'options_long_format.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 672, '12 26 15:19', 'options.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 183, '12 26 18:25', 'ls.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 3390, Time.new.strftime('%m %d %H:%M'), 'command_format_test.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 601, '12 26 18:25', 'command_format.rb'],
                  ['-', 'rw-r--r--', '1', 'saekoyamada', 'staff', 0, '6 20 22:03', '.gitkeep'],
                  ['d', 'rwxr-xr-x', '15', 'saekoyamada', 'staff', 480, '12 26 18:32', '..'],
                  ['d', 'rwxr-xr-x', '10', 'saekoyamada', 'staff', 320, '12 26 18:32', '.']], command_option('lra').list_directory
  end
end
