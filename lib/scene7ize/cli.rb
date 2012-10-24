require 'thor'

module Scene7ize

  # Facade for Scene7ize command line interface managed by [Thor](https://github.com/wycats/thor).
  # This is the main interface to Scene7ize that is called by the Scene7ize binary `bin/scene7ize`.
  # Do not put any logic in here, create a class and delegate instead.
  class CLI < Thor

    require 'scene7ize'
    require 'scene7ize/version'

    desc 'parse', 'Parses an input file, replacing image URLs with Scene7 ones'
    method_option :url_prefix,
                  :type => :string,
                  :aliases => '-u',
                  :banner => 'the Scene7 URL prefix',
                  :required => true

    method_option :input_file,
                  :type => :string,
                  :aliases => '-i',
                  :banner => 'the input file to process',
                  :required => true

    method_option :output_file,
                  :type => :string,
                  :aliases => '-o',
                  :banner => 'write to an output file instead of overwriting the input file'
    def parse

      Scene7ize.parse_file(options[:url_prefix], options[:input_file], options[:output_file])

    end


    desc 'version', 'Show the Guard version'
    map %w(-v --version) => :version

    # Shows the current version of Scene7ize.
    #
    # @see Scene7ize::VERSION
    #
    def version
      puts "Scene7ize version #{ ::Scene7ize::VERSION }"
    end
  end

end