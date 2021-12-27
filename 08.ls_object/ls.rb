#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'ls_command'

ls_command = LsCommand.new(ARGV.getopts('alr'))
ls_command.list_directory
