Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'actionpusher'
  s.version     = '0.0.1'
  s.summary     = 'Push notification composition and delivery framework (based on ActionMailer.)'
  s.description = 'Apple Push Notifications for Rails. Compose and deliver push notifications for iOS'
  s.homepage    = 'https://github.com/PetroFeed/actionpusher'

  s.required_ruby_version = '>= 1.9.3'

  s.license = 'MIT'

  s.author   = 'Gavin Miller'
  s.email    = 'gavin@petrofeed.com'

  s.files        = Dir['README.md', 'MIT-LICENSE', 'lib/**/*']
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_development_dependency 'rspec', '~> 2.14.1'
  s.add_development_dependency 'pry'

  s.add_runtime_dependency 'houston', '~> 2.0.2'
  s.add_runtime_dependency 'rails', '~> 4.0.2'
end
