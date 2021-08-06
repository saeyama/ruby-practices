#!/usr/bin/env ruby
require 'optparse'
require './options'
require './options_long_format'

options = ARGV.getopts('alr')

files = options['a'] ? Dir.glob('*', File::FNM_DOTMATCH).sort : Dir.glob('*').sort

if options['l']
  options['r'] ? list_directory_long_format(files.reverse) : list_directory_long_format(files)
else
  options['r'] ? list_directory(files.reverse) : list_directory(files)
end
