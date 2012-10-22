require 'spec_helper'

describe Scene7izer do
  it "should open a file given a valid filename"
  it "should display an error given an invalid filename"
  it "should write to an output file if provided"
  it "should replace the input file if an output file is not provided"
  it "should display logging info if verbose mode on"

  context "string matching" do
      it "should match images in HREFs" do
        Scene7izer.match('<a href="/images/xmas2012-lights-light01-on.jpg"></a>').should_not be_nil
        Scene7izer.match('<a href="non_image_file.html"></a>').should be_nil
        Scene7izer.match('<a href="/images/this-is-no-jpg.html"></a>').should be_nil
      end

      it "should match images in HTML SRCs"
      it "should match images in CSS urls"
  end

  context "scene7 path" do
    it "should contain a specified prefix"
    it "should contain a width parameter"
    it "should contain a height parameter"
    it "should contain a quality parameter given a JPG"
    it "should contain a PNG format parameter given a PNG"
    it "should contain a GIF format parameter given a GIF"
  end
end