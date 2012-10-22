# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scene7izer/version'

Gem::Specification.new do |gem|
  gem.name          = "scene7izer"
  gem.version       = Scene7izer::VERSION
  gem.authors       = ["Brad Carson"]
  gem.email         = ["brad@pixelwavedesign.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{Converts local image paths in an HTML or CSS file to Scene7 paths containing dimensions and format data}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
