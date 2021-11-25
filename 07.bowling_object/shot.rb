#!/usr/bin/env ruby
# frozen_string_literal: true

class Shot
  def initialize
    @shot_int = ARGV[0]
  end

  def score
    @shot_int.split(',').map { |s| s == 'X' ? 10 : s.to_i }
  end
end
