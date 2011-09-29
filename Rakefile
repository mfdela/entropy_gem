require "bundler/gem_tasks"
require 'rake/testtask'
require 'rdoc/task'


Rake::TestTask.new(:test) do |t|
  #t.pattern = "test/**/test*.rb"
  t.test_files = Dir.glob("test/**/test*.rb")
  t.verbose = true
  t.warning = true
end

desc 'generate API documentation to doc/rdocs/index.html'
RDoc::Task.new do |rdoc|
    rdoc.main = 'README.txt'
    rdoc.rdoc_dir = 'doc/rdocs'
    rdoc.rdoc_files.include("README.txt", "LICENSE.txt", "CHANGELOG.txt", "lib/**/*.rb")
end

desc "Run tests"
task :default => :test

