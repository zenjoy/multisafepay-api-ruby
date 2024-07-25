$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'multisafepay/version'

Gem::Specification.new do |s|
  s.name = 'multisafepay-api-ruby'
  s.version = MultiSafePay::VERSION
  s.summary = 'Unofficial MultiSafePay API Client for Ruby'
  s.description = %(Unofficial MultiSafePay API Client for Ruby. Simplifies integrating with the MultiSafePay API. Supports all API methods. See https://docs.multisafepay.com/reference/ for more information.)
  s.authors = ['Zenjoy B.V.']
  s.email = ['engineering@zenjoy.be']
  s.homepage = 'https://github.com/zenjoy/multisafepay-api-ruby'
  s.license = 'MIT'
  s.metadata = {
    'changelog_uri' => 'https://github.com/zenjoy/multisafepay-api-ruby/blob/main/CHANGELOG.md'
  }

  s.required_ruby_version = '>= 2.7.8'

  s.files = `git ls-files`.split("\n")
  s.test_files = Dir['test/**/*']

  s.add_development_dependency('rake')
  s.add_development_dependency('rubocop')
  s.add_development_dependency('test-unit')
  s.add_development_dependency('webmock')
end
