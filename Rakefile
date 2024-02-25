# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'dotenv'
require 'rake/testtask'

Dotenv.load

#system './bin/cc-test-reporter before-build'
Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

require 'rubocop/rake_task'
RuboCop::RakeTask.new
task default: %i[test rubocop]
#system './bin/cc-test-reporter after-build'
