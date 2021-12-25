#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'command_format'

ls_command = CommandFormat.new(ARGV.getopts('alr'))
ls_command.options_l?
