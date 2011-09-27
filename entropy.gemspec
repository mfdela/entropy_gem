# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "entropy/version"

Gem::Specification.new do |s|
  s.name        = "entropy"
  s.version     = Entropy::VERSION
  s.authors     = ["hiraedd"]
  s.email       = ["hiraedd@hiraedd.com"]
  s.homepage    = "https://github.com/hiraedd/entropy_gem"
  s.summary     = %q{Computes the entropy of a finite probability space}
  s.description = %q{This little gem calculates the entropy and ( the cardinality) of a finite probability space, defined by a probability vector; and of a finite probability metric space, defined by a probability vector and metric function. Requires ruby 1.9.x}

  s.rubyforge_project = "entropy"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
