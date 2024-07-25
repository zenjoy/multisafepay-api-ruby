<h1 align="center">Unofficial MultiSafePay API client for Ruby</h1>

[![Gem Version](https://badge.fury.io/rb/multisafepay-api-ruby.svg)](https://badge.fury.io/rb/multisafepay-api-ruby)
[![Build Status](https://github.com/zenjoy/multisafepay-api-ruby/actions/workflows/build.yml/badge.svg)](https://github.com/zenjoy/multisafepay-api-ruby/actions/workflows/build.yml)

## Installation

By far the easiest way to install the Multisafepay API client is to install it with
[gem](http://rubygems.org/).

```
# Gemfile
gem "multisafepay-api-ruby"

$ gem install multisafepay-api-ruby
```

You may also git checkout or
[download all the files](https://github.com/zenjoy/multisafepay-api-ruby/archive/main.zip), and
include the Multisafepay API client manually.

## Getting started

Require the Multisafepay API Client. _Not required when used with a Gemfile_

```ruby
require 'multisafepay-api-ruby'
```

Create an initializer and add the following line:

```ruby
MultiSafePay::Client.configure do |config|
  config.api_key = '<your-api-key>'
  config.environment = :test # or :live

  # Timeouts (default - 60)
  # config.open_timeout = 60
  # config.read_timeout = 60
end
```

You can also include the API Key in each request you make, for instance if you are using the Connect
API:

```ruby
MultiSafePay::Order.get('order-id', api_key: '<your-api-key>', environment: :test)
```

If you need to do multiple calls with the same API Key, use the following helper:

```ruby
MultiSafePay::Client.with_api_key('<your-api-key>') do
  MultiSafePay::Order.create(
    order_id:     '12345',
    amount:       1000,
    currency:     'EUR',
    description:  'My first API payment',
    redirect_url: 'https://webshop.example.org/order/12345/',
    webhook_url:  'https://webshop.example.org/multisafepay-webhook/'
  )
end
```

### Pagination

```ruby
payments = MultiSafePay::Transaction.all
payments.next
payments.previous
```

## API documentation

If you wish to learn more about the MultiSafePay API, please visit the
[API Documentation](https://docs.multisafepay.com/reference/).

## Contributing

Feel free to contribute and make things better by opening an
[Issue](https://github.com/zenjoy/multisafepay-api-ruby/issues) or
[Pull Request](https://github.com/zenjoy/multisafepay-api-ruby/pulls).

## License

View [license information](https://github.com/zenjoy/multisafepay-api-ruby/blob/main/LICENSE) for
the software contained in this image.

## Acknowledgements

This library is heavily inspired by the
[Mollie API client for Ruby](https://github.com/mollie/mollie-api-ruby).
