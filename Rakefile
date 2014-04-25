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
  gem_path = File.expand_path("../pkg/actionpusher-#{current_version}.gem", __FILE__)
  puts `gem push #{gem_path}`
end

def version_path
  File.expand_path('../VERSION', __FILE__)
end

def current_version
  File.read(version_path).strip
end

def modify_version_number(major_inc, minor_inc, revision_inc)
  major, minor, revision = current_version.split('.').map(&:to_i)

  new_version = [major + major_inc, minor + minor_inc, revision + revision_inc].compact.join('.')
  File.open(version_path, 'w') { |file| file.write(new_version) }
end

namespace :bump do
  desc "Bump major version number"
  task :major do
    modify_version_number(1, 0, 0)
  end

  desc "Bump minor version number"
  task :minor do
    modify_version_number(0, 1, 0)
  end

  desc "Bump revision number"
  task :revision do
    modify_version_number(0, 0, 1)
  end
end
