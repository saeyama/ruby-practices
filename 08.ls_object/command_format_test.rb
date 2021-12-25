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
    assert_equal [['command_format.rb', 'options_format.rb', 'options_long_format_test.rb'],
                  ['command_format_test.rb', 'options_format_test.rb', nil],
                  ['ls.rb', 'options_long_format.rb', nil]], command_option(' ').options_l?
  end

  def test_command2
    assert_equal [['.', 'command_format_test.rb', 'options_long_format.rb'],
                  ['..', 'ls.rb', 'options_long_format_test.rb'],
                  ['.gitkeep', 'options_format.rb', nil],
                  ['command_format.rb', 'options_format_test.rb', nil]], command_option('a').options_l?
  end

  def test_command3
    assert_equal [['options_long_format_test.rb', 'options_format.rb', 'command_format.rb'],
                  ['options_long_format.rb', 'ls.rb', nil],
                  ['options_format_test.rb', 'command_format_test.rb', nil]], command_option('r').options_l?
  end

  def test_command4
    assert_equal [['options_long_format_test.rb', 'ls.rb', '..'],
                  ['options_long_format.rb', 'command_format_test.rb', '.'],
                  ['options_format_test.rb', 'command_format.rb', nil],
                  ['options_format.rb', '.gitkeep', nil]], command_option('ar').options_l?
  end

  def test_command5
    assert_equal [['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 610, '12 25 13:57', 'command_format.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 3468, Time.new.strftime('%m %d %H:%M'), 'command_format_test.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 179, '12 25 13:59', 'ls.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 754, '12 25 13:17', 'options_format.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 1618, '12 25 13:25', 'options_format_test.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 1177, '12 25 13:17', 'options_long_format.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 1095, '12 25 13:34', 'options_long_format_test.rb']], command_option('l').options_l?
  end

  def test_command6
    assert_equal [['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 1095, '12 25 13:34', 'options_long_format_test.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 1177, '12 25 13:17', 'options_long_format.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 1618, '12 25 13:25', 'options_format_test.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 754, '12 25 13:17', 'options_format.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 179, '12 25 13:59', 'ls.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 3468, Time.new.strftime('%m %d %H:%M'), 'command_format_test.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 610, '12 25 13:57', 'command_format.rb'],
                  ['-', 'rw-r--r--', '1', 'saekoyamada', 'staff', 0, '6 20 22:03', '.gitkeep'],
                  ['d', 'rwxr-xr-x', '15', 'saekoyamada', 'staff', 480, '12 25 14:08', '..'],
                  ['d', 'rwxr-xr-x', '10', 'saekoyamada', 'staff', 320, '12 25 14:08', '.']], command_option('lra').options_l?
  end
end
