# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "camtool/version"

Gem::Specification.new do |spec|
  spec.name          = "camtool"
  spec.version       = CamTool::VERSION
  spec.authors       = ["Thomas Pasquier", 'Xuehuan "Michael" Han']
  spec.email         = ["tfjmp@seas.harvard.edu"]

  spec.summary       = %q{Tool to manipulate CamFlow log files.}
  spec.description   = %q{Allow to test, publish and manipulate camflow log files.}
  spec.homepage      = "https://github.com/tfjmp/camtool"

  spec.add_runtime_dependency "rgl", "~> 0.5"
  spec.add_runtime_dependency "rinruby", "~> 2.0"
  spec.add_runtime_dependency "json", "~> 2.1"
  spec.add_runtime_dependency "mqtt", "~> 0.5"

  spec.files        = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.md)
  spec.bindir        = "bin"
  spec.executables   = ["camtool"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.license = 'MIT'
end
