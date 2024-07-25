require 'test/unit'
require 'webmock/test_unit'

require 'multisafepay'

MultiSafePay::Client.configure do |config|
  config.api_key = '515057363773396f67614e6b7471437333637173'
end

def read_fixture(path)
  File.read(File.join(File.dirname(__FILE__), 'fixtures', path))
end
