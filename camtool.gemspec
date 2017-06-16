# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ["Thomas Pasquier"]
  gem.email         = ["tfjmp@seas.harvard.edu"]
  gem.description   = %q{Helper tool for CamFlow logs.}
  gem.summary       = %q{Read CamFlow logs and print some stats.}
  gem.homepage      = "http://camflow.org"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = ["camtool"]
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "camtool"
  gem.require_paths = ["lib"]
  gem.version       = "0.1.0"
end
