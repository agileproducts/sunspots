#! /usr/bin/env ruby
# encoding: UTF-8

require_relative '../solar_grid.rb'

describe SolarGrid do
  
  before(:each) do
    @grid = SolarGrid.new("1 5 5 3 1 2 0 4 1 1 3 2 2 3 2 4 3 0 2 3 3 2 1 0 2 4 3")
  end
  
  it "should be able to represent the datapoints as a grid" do
     @grid.datapoints.should == [[5,3,1,2,0],[4,1,1,3,2],[2,3,2,4,3],[0,2,3,3,2],[1,0,2,4,3]]
  end
      
  it "should be able to return the value of a given coordinate" do
    @grid.coordinate_value(3,2).should == 4
  end
  
  it "should be able to work out the activity score for a given coordinate" do
    @grid.coordinate_score(3,3).should == 26
    @grid.coordinate_score(1,0).should == 15
    @grid.coordinate_score(0,0).should == 13
    @grid.coordinate_score(4,2).should == 17
  end
  
  it "should be able to return the requested number of results" do
    @grid.requested_scores.should == [{ x:3, y:3, score: 26}]
  end

  
end