# frozen_string_literal: true

require_relative 'lib/tibber/version'

Gem::Specification.new do |s|
  s.name        = 'tibber'
  s.version     = Tibber::VERSION
  s.authors     = ['Janco Tanis']
  s.email       = 'gems@jancology.com'
  s.license     = 'MIT'

  s.summary     = 'A Ruby wrapper for the Tibber APIs (readonly)'
  s.homepage    = 'https://rubygems.org/gems/tibber'

  s.required_ruby_version = Gem::Requirement.new('>= 2.4.0')

  s.metadata['homepage_uri'] = s.homepage
  s.metadata['source_code_uri'] = 'https://github.com/jancotanis/tibber'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  s.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  s.bindir        = 'exe'
  s.executables   = s.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.platform = Gem::Platform::RUBY
  s.add_runtime_dependency 'faraday'
  s.add_runtime_dependency 'wrapi', ">= 0.3.0"
  s.add_development_dependency 'dotenv'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'rubocop'
end
