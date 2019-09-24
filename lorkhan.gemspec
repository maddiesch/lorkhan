lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lorkhan/version'

Gem::Specification.new do |spec|
  spec.name                  = 'lorkhan'
  spec.version               = Lorkhan::VERSION
  spec.licenses              = ['MIT']
  spec.authors               = ['Maddie Schipper']
  spec.email                 = ['me@maddiesch.com']
  spec.summary               = 'APNS HTTP/2 Client'
  spec.homepage              = 'http://github.com/maddiesch/lorkhan'

  spec.required_ruby_version = '>= 2.5.0'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %w[lib]

  spec.add_dependency 'connection_pool', '>= 2.2'
  spec.add_dependency 'jwt',             '>= 2.2.1'
  spec.add_dependency 'net-http2',       '>= 0.14.1', '< 2'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.5'
end
