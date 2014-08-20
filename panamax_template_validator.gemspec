# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'panamax_template_validator/version'

Gem::Specification.new do |spec|
  spec.name          = "panamax_template_validator"
  spec.version       = PanamaxTemplateValidator::VERSION
  spec.authors       = ["Centurylink Labs"]
  spec.email         = ["alex.welch@centurylink.com"]
  spec.summary       = %q{Validates panamax template files}
  spec.homepage      = "https://github.com/CenturyLinkLabs/panamax-template-validator"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  # spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  # spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.3"
end
