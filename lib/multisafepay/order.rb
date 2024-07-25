module MultiSafePay
  class Order < Base
    STATUS_CANCELLED   = "cancelled".freeze
    STATUS_COMPLETED   = "completed".freeze
    STATUS_DECLINED    = "declined".freeze
    STATUS_EXPIRED     = "expired".freeze
    STATUS_INITIALIZED = "initialized".freeze
    STATUS_REFUNDED    = "refunded".freeze
    STATUS_RESERVED    = "reserved".freeze
    STATUS_SHIPPED     = "shipped".freeze
    STATUS_UNCLEARED   = "uncleared".freeze
    STATUS_VOID        = "void".freeze

    attr_accessor :amount_refunded,
                  :amount,
                  :auth_order_id,
                  :costs,
                  :created,
                  :currency,
                  :customer,
                  :delivery,
                  :description,
                  :fastcheckout,
                  :financial_status,
                  :gateway,
                  :items,
                  :modified,
                  :order_id,
                  :payment_details,
                  :payment_methods,
                  :payment_options,
                  :payment_url,
                  :reason_code,
                  :reason,
                  :related_transactions,
                  :session_id,
                  :shopping_cart,
                  :status,
                  :transaction_id,
                  :type,
                  :var1,
                  :var2,
                  :var3
    
    def cancelled?
      status == STATUS_CANCELLED
    end

    def completed?
      status == STATUS_COMPLETED
    end

    def declined?
      status == STATUS_DECLINED
    end

    def expired?
      status == STATUS_EXPIRED
    end

    def initialized?
      status == STATUS_INITIALIZED
    end

    def refunded?
      status == STATUS_REFUNDED
    end

    def reserved?
      status == STATUS_RESERVED
    end

    def shipped?
      status == STATUS_SHIPPED
    end

    def uncleared?
      status == STATUS_UNCLEARED
    end

    def void?
      status == STATUS_VOID
    end

    def created=(created)
      @created = Time.parse(created.to_s)
    end
    
    def customer=(customer)
      @customer = OpenStruct.new(customer) if customer.is_a?(Hash)
    end

    def payment_options=(payment_options)
      @payment_options = OpenStruct.new(payment_options) if payment_options.is_a?(Hash)
    end

    def payment_methods=(payment_methods)
      @payment_methods = OpenStruct.new(payment_methods) if payment_methods.is_a?(Hash)
    end

    def related_transactions=(related_transactions)
      @related_transactions = OpenStruct.new(related_transactions) if related_transactions.is_a?(Hash)
    end

    def shopping_cart=(shopping_cart)
      @shopping_cart = OpenStruct.new(shopping_cart) if shopping_cart.is_a?(Hash)
    end

    class << self
      def self.refund(order_id, data = {})
        Client.instance.post("orders/#{order_id}/refunds", nil, data)
      end

      def self.capture(order_id, data = {})
        Client.instance.post("orders/#{order_id}/capture", nil, data)
      end

      def self.cancel_payment(order_id, data = {})
        raise ArgumentError, "reason is required" unless data["reason"]

        Client.instance.delete("capture/#{order_id}", nil, data.merge({
          status: STATUS_CANCELLED,
          reason: data["reason"]
        }))
      end
    end
  end
end
