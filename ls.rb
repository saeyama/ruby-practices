#!/usr/bin/env ruby
require 'optparse'
require './05.ls/options_l_alr'
require './05.ls/options_nomal_a_r'

def ls_option
  options = ARGV.getopts('alr')
  if options['a'] && options['l'] && options['r']
    ls_l_alr(Dir.glob('*', File::FNM_DOTMATCH).sort.reverse)
  elsif options['a']
    ls_nomal_a_r(Dir.glob('*', File::FNM_DOTMATCH).sort)
  elsif options['l']
    ls_l_alr(Dir.glob('*').sort)
  elsif options['r']
    ls_nomal_a_r(Dir.glob('*').sort.reverse)
  else
    ls_nomal_a_r(Dir.glob('*').sort)
  end
end

ls_option
