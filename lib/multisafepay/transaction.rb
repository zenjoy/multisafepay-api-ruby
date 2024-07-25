module MultiSafePay
  class Transaction < Base
    attr_accessor :amount,
                  :completed,
                  :costs,
                  :created,
                  :currency,
                  :customer,
                  :debit_credit,
                  :description,
                  :financial_status,
                  :invoice_id,
                  :net,
                  :order_id,
                  :payment_method,
                  :reason,
                  :reason_code,
                  :site_id,
                  :status,
                  :transaction_id,
                  :updated,
                  :type,
                  :var1,
                  :var2,
                  :var3
    
    def customer=(customer)
      @customer = OpenStruct.new(customer) if customer.is_a?(Hash)
    end
  end
end
