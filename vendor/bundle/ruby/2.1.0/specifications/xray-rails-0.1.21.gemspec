# -*- encoding: utf-8 -*-
# stub: xray-rails 0.1.21 ruby lib

Gem::Specification.new do |s|
  s.name = "xray-rails"
  s.version = "0.1.21"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Brent Dillingham"]
  s.date = "2016-05-21"
  s.description = "Provides a dev bar and an overlay in-browser to visualize your UI's rendered partials and Backbone views"
  s.email = ["brentdillingham@gmail.com"]
  s.homepage = "https://github.com/brentd/xray-rails"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.2"
  s.summary = "Reveal the structure of your UI"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 3.1.0"])
      s.add_runtime_dependency(%q<coffee-rails>, [">= 0"])
      s.add_development_dependency(%q<rspec-rails>, [">= 0"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
      s.add_development_dependency(%q<jquery-rails>, [">= 0"])
      s.add_development_dependency(%q<backbone-rails>, [">= 0"])
      s.add_development_dependency(%q<sass-rails>, [">= 0"])
      s.add_development_dependency(%q<haml>, [">= 0"])
      s.add_development_dependency(%q<eco>, [">= 0"])
      s.add_development_dependency(%q<capybara>, [">= 0"])
    else
      s.add_dependency(%q<rails>, [">= 3.1.0"])
      s.add_dependency(%q<coffee-rails>, [">= 0"])
      s.add_dependency(%q<rspec-rails>, [">= 0"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
      s.add_dependency(%q<jquery-rails>, [">= 0"])
      s.add_dependency(%q<backbone-rails>, [">= 0"])
      s.add_dependency(%q<sass-rails>, [">= 0"])
      s.add_dependency(%q<haml>, [">= 0"])
      s.add_dependency(%q<eco>, [">= 0"])
      s.add_dependency(%q<capybara>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 3.1.0"])
    s.add_dependency(%q<coffee-rails>, [">= 0"])
    s.add_dependency(%q<rspec-rails>, [">= 0"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
    s.add_dependency(%q<jquery-rails>, [">= 0"])
    s.add_dependency(%q<backbone-rails>, [">= 0"])
    s.add_dependency(%q<sass-rails>, [">= 0"])
    s.add_dependency(%q<haml>, [">= 0"])
    s.add_dependency(%q<eco>, [">= 0"])
    s.add_dependency(%q<capybara>, [">= 0"])
  end
end
