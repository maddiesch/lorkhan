$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'lorkhan'
require 'rspec'
require 'pry'

Dir[File.expand_path("../support/**/*.rb", __FILE__)].each { |f| require f }

RSpec.configure do |config|
end
