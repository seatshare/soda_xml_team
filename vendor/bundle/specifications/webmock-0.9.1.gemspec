# -*- encoding: utf-8 -*-
# stub: webmock 0.9.1 ruby lib

Gem::Specification.new do |s|
  s.name = "webmock"
  s.version = "0.9.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Bartosz Blimke"]
  s.date = "2010-02-01"
  s.description = "WebMock allows stubbing HTTP requests and setting expectations on HTTP requests."
  s.email = "bartosz.blimke@gmail.com"
  s.extra_rdoc_files = ["LICENSE", "README.md"]
  s.files = ["LICENSE", "README.md"]
  s.homepage = "http://github.com/bblimke/webmock"
  s.rdoc_options = ["--charset=UTF-8"]
  s.rubygems_version = "2.3.0"
  s.summary = "Library for stubbing HTTP requests in Ruby."

  s.installed_by_version = "2.3.0" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<addressable>, [">= 2.1.1"])
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_development_dependency(%q<httpclient>, [">= 2.1.5.2"])
    else
      s.add_dependency(%q<addressable>, [">= 2.1.1"])
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<httpclient>, [">= 2.1.5.2"])
    end
  else
    s.add_dependency(%q<addressable>, [">= 2.1.1"])
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<httpclient>, [">= 2.1.5.2"])
  end
end
