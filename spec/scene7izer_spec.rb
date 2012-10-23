require 'spec_helper'

describe Scene7izer do
  it "should open a file given a valid filename"
  it "should display an error given an invalid filename"
  it "should write to an output file if provided"
  it "should replace the input file if an output file is not provided"
  it "should display logging info if verbose mode on"
  it "should open image files relative to the input file"

  context "scene7 url" do

    before(:each) do
      @image_filename = 'test.jpg'
      @image = double("Image", :width => 10, :height => 15, :format => 'jpg')

      MiniMagick::Image.should_receive(:open).and_return(@image)
      @scene7url = Scene7izer.scene7url_from("http://example.com/scene7/", @image_filename)
    end

    it "should contain a specified prefix"

    it "should create a valid scene7 url" do
      @scene7url.should == "http://example.com/scene7/test?wid=10&hei=15&qlt=100"
    end

    it "should contain a valid width parameter" do
      @scene7url.should match /wid=10/
    end

    it "should contain a valid height parameter" do
      @scene7url.should match /hei=15/
    end

  end
end