# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lorkhan/version'

Gem::Specification.new do |spec|
  spec.name                  = 'Lorkhan'
  spec.version               = Lorkhan::VERSION
  spec.licenses              = ['MIT']
  spec.authors               = ['Skylar Schipper']
  spec.email                 = ['me@skylarsch.com']
  spec.summary               = 'APNS HTTP/2 Client'
  spec.homepage              = 'http://github.com/skylarsch/lorkhan'
  spec.required_ruby_version = '>=2.3.0'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %w(lib)

  spec.add_dependency 'net-http2',       '>= 0.14.1', '< 2'
  spec.add_dependency 'connection_pool', '>= 2.0'
  spec.add_dependency 'jwt',             '>= 1.5.6'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake',    '~> 10.0'
  spec.add_development_dependency 'rspec',   '~> 3.5'
  spec.add_development_dependency 'pry'
end
