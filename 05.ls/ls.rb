#!/usr/bin/env ruby
require 'optparse'
require './options'
require './options_long_format'

options = ARGV.getopts('alr')

files = options['a'] ? Dir.glob('*', File::FNM_DOTMATCH).sort : Dir.glob('*').sort
files_output_order = options['r'] ? files.reverse : files.sort

if options['l']
  list_directory_long_format(files_output_order)
else
  list_directory(files_output_order)
end
