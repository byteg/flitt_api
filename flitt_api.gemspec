Gem::Specification.new do |spec|
  spec.name          = "flitt_api"
  spec.version       = "0.1.0"
  spec.authors       = ["Denis Kuznetsov"]
  spec.email         = ["denis@f7.ru"]

  spec.summary       = "Flitt.com API client"
  spec.description   = "A simple Ruby client for interacting with the Flitt.com payment API."
  spec.homepage      = "https://github.com/byteg/flitt_api"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*.rb", "spec/**/*.rb"]
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"
  spec.add_development_dependency "rspec"
end
