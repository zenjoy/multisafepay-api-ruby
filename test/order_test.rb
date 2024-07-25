require 'helper'

module MultiSafePay
  class OrderTest < Test::Unit::TestCase
    CREATE_ORDER = read_fixture('orders/create.json')
    GET_ORDER    = read_fixture('orders/get.json')
    
    def test_status_pending
      assert Order.new(status: Order::STATUS_INITIALIZED).initialized?
      assert !Order.new(status: 'not-initialized').initialized?
    end

    def test_status_reserved 
      assert Order.new(status: Order::STATUS_RESERVED).reserved?
      assert !Order.new(status: 'not-reserved').reserved?
    end

    def test_status_shipped
      assert Order.new(status: Order::STATUS_SHIPPED).shipped?
      assert !Order.new(status: 'not-shipped').shipped?
    end

    def test_get_order
      stub_request(:get, 'https://api.multisafepay.com/v1/json/orders/12345')
        .to_return(status: 200, body: GET_ORDER, headers: {})

      order = Order.get('12345')
      assert_equal '12345', order.order_id
      assert_equal BigDecimal('1200'), order.amount
      assert_equal 'EUR', order.currency
      assert_equal 'completed', order.status
      assert_equal 'nl_NL', order.customer.locale
      assert_equal 'Lego cars', order.description
      assert_equal Time.parse("2024-07-25T14:28:41"), order.created
    end

    def test_create_order
      minified_body = JSON.parse(CREATE_ORDER).to_json
      stub_request(:post, 'https://api.multisafepay.com/v1/json/orders')
        .with(body: minified_body)
        .to_return(status: 201, body: GET_ORDER, headers: {})

      order = Order.create(JSON.parse(CREATE_ORDER))

      assert_kind_of Order, order
      assert_equal '12345', order.order_id
    end
  end
end
