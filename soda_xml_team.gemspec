# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'soda_xml_team/version'

Gem::Specification.new do |s|
  s.name        = 'soda_xml_team'
  s.version     = SodaXmlTeam::VERSION
  s.date        = '2014-07-13'
  s.summary     = "XML Team Sports On Demand API"
  s.description = "A basic layer for interacting XML Team's Sports On Demand API (SODA)"
  s.authors     = ["Stephen Yeargin"]
  s.email       = 'stephen@yearg.in'

  s.files = `git ls-files`.split($/)
  s.executables = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.homepage    = 'https://github.com/seatshare/soda_xml_team'
  s.license     = 'MIT'

  s.add_development_dependency "bundler", "~> 1.3"
  s.add_development_dependency "rake", "~> 0"

  s.add_dependency "nokogiri", "~> 1.6", ">= 1.6.2"
  s.add_dependency "httparty", "~> 0.13", ">= 0.13"
end