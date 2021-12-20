#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'options'
require_relative 'options_long_format'

class Command
  def initialize(options)
    # options = ARGV.getopts('alr')
    @options = options
    @files = @options['a'] ? Dir.glob('*', File::FNM_DOTMATCH).sort : Dir.glob('*').sort
    @files_output_order = @options['r'] ? @files.reverse : @files.sort
    @ls_l_option = ListDirectoryLongFormat.new(@files_output_order)
    @ls_option = ListDirectory.new(@files_output_order)
  end

  def options_l?
    if @options['l']
      @ls_l_option.list_directory_long_format
    else
      @ls_option.list_directory
    end
  end
end
