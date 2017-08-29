# -*-ruby-*-

require 'rake'
#require 'rspec/core/rake_task'
require "bundler/gem_tasks"

desc "Runs all development tests"
task :test


task :test => [:syntax]
desc "Checks ruby files for syntax errors"
task :syntax do |t|
  puts "------------Syntax-----------"
  Dir.glob('**/*.rb').each do |f|
    system("/bin/echo -n '#{f}:  '; ruby -c #{f}")
  end
end


# Rubocop
begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new(:lint)
rescue LoadError
  puts 'rubocop is not available. Install the rubocop gem to run the lint tests.'
end

#task :test => [:unit]
#desc "Runs unit tests"
#RSpec::Core::RakeTask.new(:unit) do |t|
#  t.pattern = 'test/unit/**/*_spec.rb'
#  t.rspec_opts = "-fd"
#end



