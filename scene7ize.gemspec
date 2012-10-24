# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scene7ize/version'

Gem::Specification.new do |gem|
  gem.name          = "scene7ize"
  gem.version       = Scene7ize::VERSION
  gem.authors       = ["Brad Carson"]
  gem.email         = ["brad@pixelwavedesign.com"]
  gem.description   = %q{...}
  gem.summary       = %q{Converts local image paths in an HTML or CSS file to Scene7 paths containing dimensions and format data}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'

  gem.add_dependency 'thor'
  gem.add_dependency 'mini_magick'

end
