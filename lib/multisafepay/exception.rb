module MultiSafePay
  class Exception < StandardError
  end

  class RequestError < MultiSafePay::Exception
    attr_accessor :error_code, :error_info

    def initialize(error, response = nil)
      exception.error_code = error['error_code']
      exception.error_info  = error['error_info']

      self.response = response
    end

    def to_s
      "#{error_code}: #{error_info}"
    end

    def http_headers
      response.to_hash if response
    end

    def http_body
      response.body if response
    end

    private

    attr_accessor :response
  end

  class ResourceNotFoundError < RequestError
  end
end
