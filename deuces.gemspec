# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "deuces/version"

Gem::Specification.new do |s|
  s.name        = "deuces"
  s.version     = Deuces::VERSION
  s.authors     = ["Mark Tabler"]
  s.email       = ["mark.tabler@fallingmanstudios.net"]
  s.homepage    = ""
  s.summary     = %q{A video-poker system for several wild-card games}
  s.description = %q{Deuces is a video-poker system that has a deck and hand system for playing standard video poker, Deuces Wild, and single- or two-joker games. The focus of this library is the scoring system; there is currently no player interface or payout table.}

  s.rubyforge_project = "deuces"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
