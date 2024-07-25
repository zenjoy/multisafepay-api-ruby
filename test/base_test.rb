require 'helper'

module MultiSafePay
  class BaseObject < Base
    attr_accessor :id, :foo, :my_field

    class NestedObject < Base
      attr_accessor :id, :baseobject_id, :foo
    end
  end

  class BaseTest < Test::Unit::TestCase
    def test_resource_name
      assert_equal 'baseobjects', BaseObject.resource_name
    end

    def test_nested_resource_name
      assert_equal 'baseobjects/object-id/nestedobjects', BaseObject::NestedObject.resource_name('object-id')
    end

    def test_setting_attributes
      attributes = { my_field: 'my value', extra_field: 'extra' }
      object     = BaseObject.new(attributes)

      assert_equal 'my value', object.my_field
      assert_equal attributes, object.attributes
    end

    def test_get
      stub_request(:get, 'https://api.multisafepay.com/v1/json/baseobjects/my-id')
        .to_return(status: 200, body: %({"success":true, "data":{"id":"my-id"}}), headers: {})

      resource = BaseObject.get('my-id')

      assert_equal 'my-id', resource.id
    end

    def test_nested_get
      stub_request(:get, 'https://api.multisafepay.com/v1/json/baseobjects/object-id/nestedobjects/my-id')
        .to_return(status: 200, body: %({"success":true, "data":{"id":"my-id", "baseobject_id":"object-id"}}), headers: {})

      resource = BaseObject::NestedObject.get('my-id', baseobject_id: 'object-id')

      assert_equal 'my-id', resource.id
      assert_equal 'object-id', resource.baseobject_id
    end

    def test_get_with_invalid_identifiers
      assert_raises(MultiSafePay::Exception) { BaseObject.get(nil) }
      assert_raises(MultiSafePay::Exception) { BaseObject.get(" ") }
      assert_raises(MultiSafePay::Exception) { BaseObject.get("   ") }
      assert_raises(MultiSafePay::Exception) { BaseObject.get("\t") }
      assert_raises(MultiSafePay::Exception) { BaseObject.get("\n") }
    end

    def test_create
      stub_request(:post, 'https://api.multisafepay.com/v1/json/baseobjects')
        .with(body: %({"foo":1.95}))
        .to_return(status: 201, body: %({"success":true, "data":{"id":"my-id", "foo":1.00}}), headers: {})

      resource = BaseObject.create(foo: 1.95)

      assert_equal 'my-id', resource.id
      assert_equal BigDecimal('1.00'), resource.foo
    end

    def test_nested_create
      stub_request(:post, 'https://api.multisafepay.com/v1/json/baseobjects/object-id/nestedobjects')
        .with(body: %({"foo":1.95}))
        .to_return(status: 201, body: %({"success":true, "data":{"id":"my-id", "baseobject_id":"object-id", "foo":1.00}}), headers: {}) 

      resource = BaseObject::NestedObject.create(foo: 1.95, baseobject_id: 'object-id')

      assert_equal 'my-id', resource.id
      assert_equal 'object-id', resource.baseobject_id
      assert_equal BigDecimal('1.00'), resource.foo
    end

    def test_update
      stub_request(:patch, 'https://api.multisafepay.com/v1/json/baseobjects/my-id')
        .with(body: %({"foo":1.95}))
        .to_return(status: 201, body: %({"success":true, "data":{"id":"my-id", "foo":1.00}}), headers: {})

      resource = BaseObject.update('my-id', foo: 1.95)

      assert_equal 'my-id', resource.id
      assert_equal BigDecimal('1.00'), resource.foo
    end

    def test_update_instance
      stub_request(:patch, 'https://api.multisafepay.com/v1/json/baseobjects/my-id')
        .with(body: %({"foo":1.95}))
        .to_return(status: 201, body: %({"success":true, "data":{"id":"my-id", "foo":1.00}}), headers: {})

      resource = BaseObject.new(id: 'my-id')
      resource.update(foo: 1.95)

      assert_equal 'my-id', resource.id
      assert_equal BigDecimal('1.00'), resource.foo
    end

    def test_nested_update
      stub_request(:patch, 'https://api.multisafepay.com/v1/json/baseobjects/object-id/nestedobjects/my-id')
        .with(body: %({"foo":1.95}))
        .to_return(status: 201, body: %({"success":true, "data":{"id":"my-id", "baseobject_id":"object-id", "foo":1.00}}), headers: {})

      resource = BaseObject::NestedObject.update('my-id', foo: 1.95, baseobject_id: 'object-id')

      assert_equal 'my-id', resource.id
      assert_equal 'object-id', resource.baseobject_id
      assert_equal BigDecimal('1.00'), resource.foo
    end

    def test_nested_update_instance
      stub_request(:patch, 'https://api.multisafepay.com/v1/json/baseobjects/object-id/nestedobjects/my-id')
        .with(body: %({"foo":1.95}))
        .to_return(status: 201, body: %({"success":true, "data":{"id":"my-id", "baseobject_id":"object-id", "foo":1.00}}), headers: {})

      resource = BaseObject::NestedObject.new(id: 'my-id', baseobject_id: 'object-id')
      resource.update(foo: 1.95)

      assert_equal 'my-id', resource.id
      assert_equal 'object-id', resource.baseobject_id
      assert_equal BigDecimal('1.00'), resource.foo
    end

    def test_delete
      stub_request(:delete, 'https://api.multisafepay.com/v1/json/baseobjects/my-id')
        .to_return(status: 204, headers: {})

      resource = BaseObject.delete('my-id')

      assert_equal nil, resource
    end

    def test_delete_instance
      stub_request(:delete, 'https://api.multisafepay.com/v1/json/baseobjects/my-id')
        .to_return(status: 204, headers: {})

      resource = BaseObject.new(id: 'my-id')

      assert_equal nil, resource.delete
    end

    def test_nested_delete
      stub_request(:delete, 'https://api.multisafepay.com/v1/json/baseobjects/object-id/nestedobjects/my-id')
        .to_return(status: 204, headers: {})

      resource = BaseObject::NestedObject.delete('my-id', baseobject_id: 'object-id')

      assert_equal nil, resource
    end

    def test_nested_delete_instance
      stub_request(:delete, 'https://api.multisafepay.com/v1/json/baseobjects/object-id/nestedobjects/my-id')
        .to_return(status: 204, headers: {})

      resource = BaseObject::NestedObject.new(id: 'my-id', baseobject_id: 'object-id')

      assert_equal nil, resource.delete
    end

    def test_all
      stub_request(:get, 'https://api.multisafepay.com/v1/json/baseobjects')
        .to_return(status: 200, body: %({"success":true, "data":[{"id":"my-id"}]}), headers: {})

      resource = BaseObject.all

      assert_equal 'my-id', resource.first.id
    end

    def test_nested_all
      stub_request(:get, 'https://api.multisafepay.com/v1/json/nestedobjects')
        .to_return(status: 200, body: %({"success":true, "data":[{"id":"my-id"}]}), headers: {})

      resource = BaseObject::NestedObject.all

      assert_equal 'my-id', resource.first.id
    end

    def test_nested_all_scoped
      stub_request(:get, 'https://api.multisafepay.com/v1/json/baseobjects/object-id/nestedobjects')
        .to_return(status: 200, body: %({"success":true, "data": [{"id":"my-id"}]}), headers: {})

      resource = BaseObject::NestedObject.all(baseobject_id: 'object-id')

      assert_equal 'my-id', resource.first.id
    end
  end
end
