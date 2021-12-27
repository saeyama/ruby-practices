#!/usr/bin/env ruby
# frozen_string_literal: true

require 'minitest/autorun'
require 'date'
require_relative 'ls_command'

class LsCommandTest < Minitest::Test
  def ls_command(option)
    LsCommand.new(option)
  end

  def test_ls_command1
    assert_equal [['long_formatter.rb', 'ls_command.rb', 'short_formatter_test.rb'],
                  ['long_formatter_test.rb', 'ls_command_test.rb', nil],
                  ['ls.rb', 'short_formatter.rb', nil]], ls_command(' ').list_directory
  end

  def test_ls_command2
    assert_equal [['.', 'long_formatter_test.rb', 'short_formatter.rb'],
                  ['..', 'ls.rb', 'short_formatter_test.rb'],
                  ['.gitkeep', 'ls_command.rb', nil],
                  ['long_formatter.rb', 'ls_command_test.rb', nil]], ls_command('a').list_directory
  end

  def test_ls_command3
    assert_equal [['short_formatter_test.rb', 'ls_command.rb', 'long_formatter.rb'],
                  ['short_formatter.rb', 'ls.rb', nil],
                  ['ls_command_test.rb', 'long_formatter_test.rb', nil]], ls_command('r').list_directory
  end

  def test_ls_command4
    assert_equal [['short_formatter_test.rb', 'ls.rb', '..'],
                  ['short_formatter.rb', 'long_formatter_test.rb', '.'],
                  ['ls_command_test.rb', 'long_formatter.rb', nil],
                  ['ls_command.rb', '.gitkeep', nil]], ls_command('ar').list_directory
  end

  def test_ls_command5
    assert_equal [['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 1173, '12 27 19:39', 'long_formatter.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 1013, '12 27 19:49', 'long_formatter_test.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 175, '12 27 19:28', 'ls.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 603, '12 27 19:27', 'ls_command.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 3374, Time.new.strftime('%m %d %H:%M'), 'ls_command_test.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 656, '12 27 19:41', 'short_formatter.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 1579, '12 27 19:44', 'short_formatter_test.rb']], ls_command('l').list_directory
  end

  def test_ls_command6
    assert_equal [['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 1579, '12 27 19:44', 'short_formatter_test.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 656, '12 27 19:41', 'short_formatter.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 3374, Time.new.strftime('%m %d %H:%M'), 'ls_command_test.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 603, '12 27 19:27', 'ls_command.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 175, '12 27 19:28', 'ls.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 1013, '12 27 19:49', 'long_formatter_test.rb'],
                  ['-', 'rwxr-xr-x', '1', 'saekoyamada', 'staff', 1173, '12 27 19:39', 'long_formatter.rb'],
                  ['-', 'rw-r--r--', '1', 'saekoyamada', 'staff', 0, '6 20 22:03', '.gitkeep'],
                  ['d', 'rwxr-xr-x', '15', 'saekoyamada', 'staff', 480, '12 27 20:00', '..'],
                  ['d', 'rwxr-xr-x', '10', 'saekoyamada', 'staff', 320, '12 27 20:00', '.']], ls_command('lra').list_directory
  end
end
