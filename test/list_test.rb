require 'helper'

module MultiSafePay
  class ListTest < Test::Unit::TestCase
    def test_setting_attributes
      attributes = {
        'data' => [
          { 'transaction_id' => 'tr_1' },
          { 'transaction_id' => 'tr_2' }
        ],
        'pager'      => {
          'previous' => 'https://api.multisafepay.com/v1/json/transactions?before=ZARmolK1dAQApbqg&limit=2',
          'next' => 'https://api.multisafepay.com/v1/json/transactions?after=ZARmolK1dAQApbqg&limit=2'
        }
      }

      list = MultiSafePay::List.new(attributes, Transaction)

      assert_equal 2, list.count
      assert_equal 2, list.size
      assert_kind_of Transaction, list.to_a[0]
      assert_equal 'tr_1', list.to_a[0].transaction_id
      assert_equal 'tr_1', list[0].transaction_id

      assert_kind_of Transaction, list.to_a[1]
      assert_equal 'tr_2', list.to_a[1].transaction_id
      assert_equal 'tr_2', list[1].transaction_id
    end

    def test_next_page
      stub_request(:get, 'https://api.multisafepay.com/v1/json/transactions?after=ZARmolK1dAQApbqg&limit=2')
        .to_return(
          status: 200,
          body: %({"success":true, "data":[{"transaction_id":"tr_1"},{"transaction_id":"tr_2"}]}), 
          headers: {}
        )

      attributes = {
        'pager' => {
          'after' => "https://api.multisafepay.com/v1/json/transactions?after=ZARmolK1dAQApbqg&limit=2"
        }
      }

      list = MultiSafePay::List.new(attributes, Transaction)
      assert_equal 2, list.next.count
    end

    def test_previous_page
      stub_request(:get, 'https://api.multisafepay.com/v1/json/transactions?before=ZARmolK1dAQApbqg&limit=2')
        .to_return(
          status: 200,
          body: %({"success":true, "data":[{"transaction_id":"tr_1"},{"transaction_id":"tr_2"}]}), 
          headers: {}
        )

      attributes = {
        'pager' => {
          'before' => "https://api.multisafepay.com/v1/json/transactions?before=ZARmolK1dAQApbqg&limit=2"
        }
      }

      list = MultiSafePay::List.new(attributes, Transaction)
      assert_equal 2, list.previous.size
    end
  end
end
