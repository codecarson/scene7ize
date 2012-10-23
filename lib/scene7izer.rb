require "scene7izer/version"
require 'mini_magick'
require 'uri'

module Scene7izer
  DEFAULT_REGEX = /[\.\.\/]*images\/(.*)(jpg|png|gif)(?=['")])/i


  def self.scene7url_from(scene7prefix, image_filename)
    # TODO: error handling
    image = MiniMagick::Image.open(image_filename)

    suffix = case image.format.downcase
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
    URI.join(scene7prefix, "#{basename}?wid=#{image.width}&hei=#{image.height}#{suffix}").to_s
  end


  def self.parse_file(scene7prefix, input_file, output_file = nil)

    file_content = File.read(input_file)
    replacement = file_content.gsub!(DEFAULT_REGEX) do |image_filename|

      # reconstruct image path relative to input file and open
      image_filename = File.join(input_path, image_filename)
      self.scene7url_from(scene7prefix, image_filename)
    end

    output_file = input_file if output_file.nil?
    File.open(output_file, "w") { |file| file.puts replacement }

  end

end
