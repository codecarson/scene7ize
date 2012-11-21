# Scene7ize

Converts local image paths in an HTML or CSS file to Scene7 paths containing dimensions and format info.  Will make working with Scene7 a little less unbearable.

Automatically assumes JPGs have been optimized, default quality is set to 100.

## Installation

    $ gem install scene7ize

## Usage

The first argument is the Scene7 URL prefix.
The second argument is an input file.
Third argument (optional) is an output file.

To run in "safe mode", specify an output file:

    $ scene7ize parse -u http://s7.example.com -i index.html -o output.html

Or, omit the output file to replace contents of an input file.

    $ scene7ize parse -u http://s7.example.com -i index.html

## TODO

1. Code documentation
2. Better error handling and documentation for arguments
3. Accept a default parameter to set JPEG quality
4. Create a way to reverse the Scene7ize process and restore original paths (likely by searching path for image files)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
