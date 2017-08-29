# coding: utf-8    # -*-ruby-*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chef-attribute-validator/version'

Gem::Specification.new do |spec|
  spec.name          = 'chef-attribute-validator'
  spec.version       = Chef::Attribute::Validator::VERSION
  spec.authors       = ['Clinton Wolfe']
  spec.email         = ['clintoncwolfe@gmail.com']
  spec.description   = %q{Define, enforce, and handle violations of validation rules for Chef node attributes.  This gem provides the validation engine, and can be used outside of a convergence run; a cookbook (attribute-validator) is available to perform validation during a chef run, at compile or converge time.}
  spec.summary       = %q{A Rubygem implementing a rule engine for validating Chef node attributes.}
  spec.homepage      = 'https://github.com/clintoncwolfe/chef-attribute-validator'
  spec.license       = 'BSD (3-clause)'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.6'
  spec.add_development_dependency 'rubocop', '~> 0.49'

  spec.add_runtime_dependency 'chef', '>= 11.6'
end
