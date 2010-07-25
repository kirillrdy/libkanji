require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "libkanji"
    gem.summary = %Q{For All Your Kanji Needs}
    gem.description = %Q{libkanji for analysis and all sorts of awesome things with Kanji}
    gem.email = "kirillrdy@silverpond.com.au"
    gem.homepage = "http://github.com/kirillrdy/libkanji"
    gem.authors = ["Kirill Radzikhovskyy"]
    gem.add_development_dependency "thoughtbot-shoulda", ">= 0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
    gem.files += Dir["lib/**/*"]
    gem.files += Dir["data/**/*"]

  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "libkanji #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
