require 'helper'

module MultiSafePay
  class ClientTest < Test::Unit::TestCase
    def client
      MultiSafePay::Client.new('515057363773396f67614e6b7471437333637175')
    end

    def test_initialize
      assert_equal '515057363773396f67614e6b7471437333637175', client.api_key
    end

    def test_setting_the_api_endpoint
      client              = self.client
      client.api_endpoint = 'http://my.endpoint/'
      assert_equal 'http://my.endpoint', client.api_endpoint
    end

    def test_perform_http_call_defaults
      stub_request(:any, 'https://api.multisafepay.com/v1/json/my-method')
        .with(headers: { 'Accept' => 'application/json',
                         'Content-type'  => 'application/json',
                         'api-key' => '515057363773396f67614e6b7471437333637175',
                         'User-Agent'    => /^MultiSafePay\/#{MultiSafePay::VERSION} Ruby\/#{RUBY_VERSION} OpenSSL\/.*$/ })
        .to_return(status: 200, body: '{}', headers: {})
      client.perform_http_call('GET', 'my-method', nil, {})
    end

    def test_perform_http_call_key_override
      stub_request(:any, 'https://localhost/v1/json/my-method')
        .with(headers: { 'Accept' => 'application/json',
                         'Content-type'  => 'application/json',
                         'api-key' => 'my_key',
                         'User-Agent'    => /^MultiSafePay\/#{MultiSafePay::VERSION} Ruby\/#{RUBY_VERSION} OpenSSL\/.*$/ })
        .to_return(status: 200, body: '{}', headers: {})
      client.perform_http_call('GET', 'my-method', nil, { api_key: 'my_key', api_endpoint: 'https://localhost' })
      client.perform_http_call('GET', 'my-method', nil, {}, { api_key: 'my_key', api_endpoint: 'https://localhost' })
    end

    def test_perform_http_call_with_api_key_block
      stub_request(:any, 'https://api.multisafepay.com/v1/json/my-method')
        .with(headers: { 'Accept' => 'application/json',
                         'Content-type'  => 'application/json',
                         'api-key' => 'my_key',
                         'User-Agent'    => /^MultiSafePay\/#{MultiSafePay::VERSION} Ruby\/#{RUBY_VERSION} OpenSSL\/.*$/ })
        .to_return(status: 200, body: '{}', headers: {})

      MultiSafePay::Client.instance.api_key = '515057363773396f67614e6b7471437333637175'
      MultiSafePay::Client.with_api_key('my_key') do
        assert_equal 'my_key', MultiSafePay::Client.instance.api_key
        MultiSafePay::Client.instance.perform_http_call('GET', 'my-method', nil, {})
      end
      assert_equal '515057363773396f67614e6b7471437333637175', MultiSafePay::Client.instance.api_key
    end

    def test_delete_requests_with_no_content_responses
      stub_request(:delete, 'https://api.multisafepay.com/v1/json/my-method/1')
        .to_return(status: 204, body: '', headers: {})

      client.perform_http_call('DELETE', 'my-method', '1')
    end

    def test_error_response
      response = <<-JSON
        {
            "success": false,
            "data": {},
            "error_code": 1032,
            "error_info": "Invalid API key"
        }
      JSON

      json = JSON.parse(response)
      stub_request(:post, 'https://api.multisafepay.com/v1/json/my-method')
        .to_return(status: 401, body: response, headers: {})

      e = assert_raise MultiSafePay::RequestError.new(JSON.parse(response)) do
        client.perform_http_call('POST', 'my-method', nil, {})
      end

      assert_equal(json['error_code'], e.error_code)
      assert_equal(json['error_info'],  e.error_info)
    end
  end
end
