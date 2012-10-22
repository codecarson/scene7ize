# use like so:
# ruby scene7izer.rb media/styles/christmas2012/trees/trees.css out.css

# references:
# http://www.imagemagick.org/RMagick/doc/usage.html
# http://davidbeckingsale.com/2011/04/23/parsing-files-with-ruby.html
# https://github.com/probablycorey/mini_magick
# http://ruby-doc.org/core-1.8.7/File.html#method-c-dirname

require 'mini_magick'

in_file = ARGV.first || 'index.html'
out_file = File.open(ARGV[1] || 'output.html', 'w')

# try to match patterns of this type
image_regex = ARGV[2].nil? ? /[\.\.\/]*images\/(.*)(jpg|png|gif)/ : Regexp.new(ARGV[2])

# grab the path of the source file, so we can load images relative to it
# e.g.  ../../../../images/xmas2012-trees-bg.jpg
in_path = File.dirname(in_file)

File.readlines(File.join(in_file)).each do |line|
  if (filename = image_regex.match line)

    puts "Trying to open file '#{filename}'"

    # strip out path from file name
    s = File.join(in_path, filename.to_s)
    image = MiniMagick::Image.open(s)

    # print "#{image[:width]} x #{image[:height]} #{image[:format]}"

    # grab the filename with no extensions or path
    basename = File.basename(s).chomp(File.extname(s))

    puts "Original: #{line}"

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

    line = line.sub(image_regex, "http://s7d5.scene7.com/is/image/CanadianTire/#{basename}?wid=#{image[:width]}&hei=#{image[:height]}" + suffix)

    puts "Converted: #{line}"
    print line
  end

  # write to file
  out_file.puts line
end

out_file.close