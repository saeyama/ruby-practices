#!/usr/bin/env ruby
# frozen_string_literal: true

require 'minitest/autorun'
require 'date'
require_relative 'options_format'

class OptionsFormatTest < Minitest::Test
  def options_format(directory)
    OptionsFormat.new(directory)
  end

  def test_options1
    assert_equal [['command_format.rb', 'options_format.rb', 'options_long_format_test.rb'],
                  ['command_format_test.rb', 'options_format_test.rb', nil],
                  ['ls.rb', 'options_long_format.rb', nil]], options_format(Dir.glob('*').sort).list_directory
  end

  def test_options2
    assert_equal [['.', 'command_format_test.rb', 'options_long_format.rb'],
                  ['..', 'ls.rb', 'options_long_format_test.rb'],
                  ['.gitkeep', 'options_format.rb', nil],
                  ['command_format.rb', 'options_format_test.rb', nil]], options_format(Dir.glob('*', File::FNM_DOTMATCH).sort).list_directory
  end

  def test_options3
    assert_equal [['options_long_format_test.rb', 'options_format.rb', 'command_format.rb'],
                  ['options_long_format.rb', 'ls.rb', nil],
                  ['options_format_test.rb', 'command_format_test.rb', nil]], options_format(Dir.glob('*').sort.reverse).list_directory
  end

  def test_options4
    assert_equal [['options_long_format_test.rb', 'ls.rb', '..'],
                  ['options_long_format.rb', 'command_format_test.rb', '.'],
                  ['options_format_test.rb', 'command_format.rb', nil],
                  ['options_format.rb', '.gitkeep', nil]], options_format(Dir.glob('*', File::FNM_DOTMATCH).sort.reverse).list_directory
  end
end
