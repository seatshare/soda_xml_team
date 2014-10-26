# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'soda_xml_team/version'

Gem::Specification.new do |spec|
  spec.name          = "soda_xml_team"
  spec.version       = SodaXmlTeam::VERSION
  spec.authors       = ["Stephen Yeargin"]
  spec.email         = ["stephen@seatsha.re"]
  spec.summary       = %q{XML Team Sports On Demand API}
  spec.description   = %q{A basic layer for interacting with XML Team's Sports On Demand API (SODA)}
  spec.homepage      = "https://github.com/seatshare/soda_xml_team"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"

  spec.add_dependency "nokogiri", ">= 1.6.3"
  spec.add_dependency "httparty", ">= 0.13"
end
