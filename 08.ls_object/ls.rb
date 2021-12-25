#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'command_format'

ls_command = Command.new(ARGV.getopts('alr'))
ls_command.options_l?
