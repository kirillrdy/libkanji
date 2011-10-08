# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "libkanji/version"

Gem::Specification.new do |s|
  s.name        = "libkanji"
  s.version     = Libkanji::VERSION
  s.authors     = ["Kirill Radzikhovskyy","Robert Gravina"]
  s.email       = ["kirillrdy@gmail.com"]
  s.homepage    = "https://github.com/kirillrdy/libkanji"
  s.summary     = %q{for all your kanji needs}
  s.description = %q{Library for all your kanji needs}

  s.rubyforge_project = "libkanji"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
