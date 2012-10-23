require 'spec_helper'

describe Scene7izer do

  context "#parse_file" do

    before(:each) do
      @input_filename = 'index.html'
      @output_filename = 'output.html'
      @image = double("Image", :width => 10, :height => 15, :format => 'jpg')
      @s7_url_prefix = 'http://s7.example.com'
      @s7_url = "#{@s7_url_prefix}/test-image?wid=#{@image.width}&hei=#{@image.height}&qlt=100"

      # I suspect that in this test we really don't even care about the file contents and could
      # omit this from the test since we are really just ensuring a different output file is
      # being written?

      @input_data = <<-CONTENTS
        <p id="jpg"><a href="test-image.jpg"><img src="test-image.jpg" alt="Test jpg"></a></p>
      CONTENTS

      @output_data = <<-CONTENTS
        <p id="jpg"><a href="#{@s7_url}"><img src="#{@s7_url}" alt="Test jpg"></a></p>
      CONTENTS
    end

    it "should write to an output file when one is given" do
      File.stub(:read).with(@input_filename) { @input_data }
      File.should_not_receive(:open).with(@input_filename)
      File.should_receive(:open).with(@output_filename, 'w').and_return(@output_data)
      Scene7izer.parse_file(@s7_url_prefix, @input_filename, @output_filename)
    end

    it "should overwrite input file when an output is not specified" do
      File.stub(:read).with(@input_filename) { @input_data }
      File.should_not_receive(:open).with(@output_filename)
      File.should_receive(:open).with(@input_filename, 'w').and_return(@output_data)
      Scene7izer.parse_file(@s7_url_prefix, @input_filename)
    end

    it "should display an error given an invalid input file" do
      expect { Scene7izer.parse_file(@s7_url_prefix, 'file-that-doesnt-exist.ext') }.to raise_error
    end

  end



  context "#scene7url_from" do

    context "given a supported image" do
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

      it "should contain a quality format parameter" do
        @scene7url.should match /qlt=100/
      end

      it "should not contain a file extension" do
        @scene7url.should_not match /\.(jpg|png|jpeg|gif)\?/
      end
    end

    it "given a PNG, should contain a valid format parameter" do
      @image_filename = 'test.png'
      @image = double("Image", :width => 10, :height => 15, :format => 'png')

      MiniMagick::Image.should_receive(:open).and_return(@image)
      @scene7url = Scene7izer.scene7url_from("http://example.com/scene7/", @image_filename)

      @scene7url.should match /fmt=png-alpha/
      @scene7url.should_not match /fmt=gif-alpha/
      @scene7url.should_not match /qlt=\d{1,}/
    end

    it "given a GIF, should contain a valid format parameter" do
      @image_filename = 'test.gif'
      @image = double("Image", :width => 10, :height => 15, :format => 'gif')

      MiniMagick::Image.should_receive(:open).and_return(@image)
      @scene7url = Scene7izer.scene7url_from("http://example.com/scene7/", @image_filename)

      @scene7url.should match /fmt=gif-alpha/
      @scene7url.should_not match /fmt=png-alpha/
      @scene7url.should_not match /qlt=\d{1,}/
    end

    it "should throw an error if not a valid image file" do
      @image_filename = 'test.png'

      expect { Scene7izer.scene7url_from("http://example.com/scene7/", @image_filename) }.to raise_error
    end

  end

end