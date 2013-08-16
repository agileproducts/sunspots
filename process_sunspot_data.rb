#! /usr/bin/env ruby
# encoding: utf-8

require_relative 'solar_grid.rb'

if ARGV[0].nil?
  puts "Usage: process_sunspot_data.rb [datafilename]"
  exit 1
end

puts "Processing NASA sunspot data:"

beginning = Time.now

File.foreach(ARGV[0]) do |line|
  @grid = SolarGrid.new(line)
  @grid.requested_scores.each { |score| puts "( #{score[:x]},#{score[:y]} score:#{score[:score]} )"}
end

puts "Time elapsed #{Time.now - beginning} seconds"