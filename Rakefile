require 'rspec/core/rake_task'
require 'rubygems/package_task'

task :default => :spec
RSpec::Core::RakeTask.new(:spec)


spec = eval(File.read('actionpusher.gemspec'))
Gem::PackageTask.new(spec) do |p|
  p.gem_spec = spec
end

desc "Release to rubygems"
task release: :package do
  require 'rake/gemcutter'
  Rake::Gemcutter::Tasks.new(spec).define
  Rake::Task['gem:push'].invoke
end
