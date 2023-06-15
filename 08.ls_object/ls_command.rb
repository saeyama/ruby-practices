#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'short_formatter'
require_relative 'long_formatter'

class LsCommand
  def initialize(options)
    @options = options
    @files = @options['a'] ? Dir.glob('*', File::FNM_DOTMATCH).sort : Dir.glob('*').sort
    @files_output_order = @options['r'] ? @files.reverse : @files.sort
    @ls_l_option = LongFormatter.new(@files_output_order)
    @ls_option = ShortFormatter.new(@files_output_order)
  end

  def list_directory
    if @options['l']
      @ls_l_option.list_directory
    else
      @ls_option.list_directory
    end
  end
end
