require 'spec_helper'

describe Scene7izer do
  it "should open a file given a valid filename"
  it "should display an error given an invalid filename"
  it "should write to an output file if provided"
  it "should replace the input file if an output file is not provided"
  it "should display logging info if verbose mode on"

  context "scene7 path" do
    it "should contain a specified prefix"
    it "should contain a width parameter"
    it "should contain a height parameter"
    it "should contain a quality parameter given a JPG"
    it "should contain a PNG format parameter given a PNG"
    it "should contain a GIF format parameter given a GIF"
  end
end