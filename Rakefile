# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "eis"
  gem.homepage = "http://github.com/aheumaier/eis"
  gem.license = "MIT"
  gem.summary = %Q{EIS - Ela Integration Service}
  gem.description = %Q{EIS is simple description-based model for IntegrationsCheck. EIS loads descriptive files(yml/json) and performs modules-based resource checks giving back an json-report as a service. Give it a module directory and it will parse any relevant files within based on a given data set }
  gem.email = "developer@andreasheumaier.de"
  gem.authors = ["Andreas Heumaier"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end


desc "Run RSpec with code coverage"
task :coverage do
  require "simplecov"
  ENV['COVERAGE'] = true
  Rake::Task["spec"].execute
end

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "eis #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
