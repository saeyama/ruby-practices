#!/usr/bin/env ruby
require 'optparse'
require './options_l_alr'
require './options_nomal_a_r'

options = ARGV.getopts('alr')

files =
  if options['a']
    Dir.glob('*', File::FNM_DOTMATCH).sort
  elsif options['r']
    Dir.glob('*').sort.reverse
  else
    Dir.glob('*').sort
  end

if options['a'] && options['l']
  ls_l_alr(files.reverse)
elsif options['l'] || options['l'] && files
  ls_l_alr(files)
else
  ls_nomal_a_r(files)
end
