# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{libkanji}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kirill Radzikhovskyy"]
  s.date = %q{2010-07-25}
  s.description = %q{libkanji for analysis and all sorts of awesome things with Kanji}
  s.email = %q{kirillrdy@silverpond.com.au}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "data/dictionary.txt",
     "data/ruby.txt",
     "lib/libkanji.rb",
     "lib/libkanji/dictionary.rb",
     "lib/libkanji/dictionary_word.rb",
     "lib/libkanji/sentence.rb",
     "lib/libkanji/sentence_word.rb",
     "libkanji.gemspec",
     "old/analyzer.rb",
     "old/data/kanji_template.svg",
     "old/data/kanjidic2.xml",
     "old/data/kitchen.txt",
     "old/data/strokes.xml",
     "old/data/yugi.txt",
     "old/kanji_from_font.rb",
     "old/kanji_strokes.rb",
     "old/libdic.rb",
     "old/libkanji.rb",
     "old/svg_output.rb",
     "test_libkanji.rb"
  ]
  s.homepage = %q{http://github.com/kirillrdy/libkanji}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{For All Your Kanji Needs}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    else
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    end
  else
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
  end
end
