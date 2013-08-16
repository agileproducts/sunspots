#! /usr/bin/env ruby
# encoding:utf-8

# My attempt at the Springer Sunspots test
# Stephen Cornelius, July 2013

# Expects input to be a space delimited string of numbers
# e.g. SolarGrid.new(1 3 4 2 3 2...)

# End goal: [{:x, :y, :score}, {:x, :y, :score}]

class SolarGrid
  
  attr_reader :number_results_wanted, :gridsize, :datapoints
  
  def initialize(datastring)
    @rawdata = datastring.split("\s").map! { |x| x.to_i }
    @number_results_wanted = @rawdata[0] 
    @gridsize = @rawdata[1]
    @grid = self.coordinates(0..@gridsize-1, 0..@gridsize-1)
    @datapoints = @rawdata.last(@rawdata.length - 2).each_slice(@gridsize).to_a
  end
    
  #generate a set of cartesian coordinates from a range of ordinates  
  def coordinates(x_range, y_range)
    x_ordinates = (x_range).to_a
    y_ordinates = (y_range).to_a
    x_ordinates.product(y_ordinates)
  end
  
  #value of one datapoint, masking coordinate reversal due to horizontal slicing
  def coordinate_value(x,y)
    @datapoints[y][x] 
  end

  #sum of datapoint + all surrounding datapoints excluding those outside boundary of grid
  def coordinate_score(x,y)
    surrounders = coordinates(x-1..x+1, y-1..y+1)
    valids = surrounders.select { |coord| coord[0].between?(0,@gridsize-1) && coord[1].between?(0,@gridsize-1) }
    score = 0
    valids.each { |valid| score += coordinate_value(valid[0],valid[1]) }
    score
  end
    
  #return the reuested amount of data in a usable format  
  def requested_scores
    scores = @grid.map { |coord| { x:coord[0], y:coord[1], score:coordinate_score(coord[0],coord[1]) } }
    scores.sort_by! { |hsh| hsh[:score] }
    scores.reverse!
    scores.take(@number_results_wanted)
  end
  

  
end