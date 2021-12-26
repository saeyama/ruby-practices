#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'options'
require_relative 'options_long_format'

class CommandFormat
  def initialize(options)
    @options = options
    @files = @options['a'] ? Dir.glob('*', File::FNM_DOTMATCH).sort : Dir.glob('*').sort
    @files_output_order = @options['r'] ? @files.reverse : @files.sort
    @ls_l_option = OptionsLongFormat.new(@files_output_order)
    @ls_option = Options.new(@files_output_order)
  end

  def option
    if @options['l']
      @ls_l_option.list_directory
    else
      @ls_option.list_directory
    end
  end
end
