# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rpstree/version'

Gem::Specification.new do |spec|
  spec.name          = "rpstree"
  spec.version       = Rpstree::VERSION
  spec.authors       = ["James Punnett"]
  spec.email         = ["jppunnett@yahoo.com"]
  spec.description   = %q{Displays process tree.}
  spec.summary       = %q{Displays process tree for one or more processes.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency('rdoc')
  spec.add_development_dependency('aruba')
  spec.add_development_dependency('rake', '~> 0.9.2')
  
  spec.add_dependency('methadone', '~> 1.3.0')
  spec.add_dependency('sys-proctable')
  spec.add_dependency('rubytree')  
end
