require "scene7ize/version"
require 'mini_magick'
require 'uri'

module Scene7ize
  DEFAULT_REGEX = /(?<=['"\())])(?<dir_and_basename>((?!['"\)]).)*)\.(?<ext>gif|jpg|jpeg|png)(?=['"\)])/i

  class << self; attr_accessor :scene7prefix; end

  def self.scene7url_from(image_filename)
    # TODO: error handling
    image = MiniMagick::Image.open(image_filename)

    suffix = case image[:format].downcase
      when 'jpg', 'jpeg'
        '&qlt=100'
      when 'png'
        '&fmt=png-alpha'
      when 'gif'
        '&fmt=gif-alpha'
      else
        ""
    end

    basename = File.basename(image_filename, File.extname(image_filename))

    # TODO: error handle  URI::InvalidURIError
    URI.join(self.scene7prefix, "#{basename}?wid=#{image[:width]}&hei=#{image[:height]}#{suffix}").to_s
  end


  def self.replace(content)
    replacement = content.gsub(DEFAULT_REGEX) do |match|
      image_filename = "#{$~[:dir_and_basename]}.#{$~[:ext]}"

      # reconstruct image path relative to input file and open
      image_filename = File.join(@input_file_path, image_filename)
      self.scene7url_from(image_filename)
    end
  end


  def self.parse_file(scene7prefix, input_file, output_file = nil)
    @scene7prefix = scene7prefix

    file_content = File.read(input_file)
    @input_file_path = File.dirname(input_file)

    replacement = replace(file_content)

    output_file = input_file if output_file.nil?
    File.open(output_file, "w") { |file| file.puts replacement }

  end
end
