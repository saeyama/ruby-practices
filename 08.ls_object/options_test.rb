#!/usr/bin/env ruby
# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'options'

class OptionsTest < Minitest::Test
  def options(directory)
    Options.new(directory)
  end

  def test_options1
    assert_equal [['command_format.rb', 'options.rb', 'options_test.rb'],
                  ['command_format_test.rb', 'options_long_format.rb', nil],
                  ['ls.rb', 'options_long_format_test.rb', nil]], options(Dir.glob('*').sort).list_directory
  end

  def test_options2
    assert_equal [['.', 'command_format_test.rb', 'options_long_format_test.rb'],
                  ['..', 'ls.rb', 'options_test.rb'],
                  ['.gitkeep', 'options.rb', nil],
                  ['command_format.rb', 'options_long_format.rb', nil]], options(Dir.glob('*', File::FNM_DOTMATCH).sort).list_directory
  end

  def test_options3
    assert_equal [['options_test.rb', 'options.rb', 'command_format.rb'],
                  ['options_long_format_test.rb', 'ls.rb', nil],
                  ['options_long_format.rb', 'command_format_test.rb', nil]], options(Dir.glob('*').sort.reverse).list_directory
  end

  def test_options4
    assert_equal [['options_test.rb', 'ls.rb', '..'],
                  ['options_long_format_test.rb', 'command_format_test.rb', '.'],
                  ['options_long_format.rb', 'command_format.rb', nil],
                  ['options.rb', '.gitkeep', nil]], options(Dir.glob('*', File::FNM_DOTMATCH).sort.reverse).list_directory
  end
end
