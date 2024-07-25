module MultiSafePay
  class Method < Base
    # Payment methods
    ALIPAY     = "ALIPAY".freeze
    ALIPAYPLUS = "ALIPAYPLUS".freeze
    AMAZONBTN  = "AMAZONBTN".freeze
    AMEX       = "AMEX".freeze
    APPLEPAY   = "APPLEPAY".freeze
    MISTERCASH = "MISTERCASH".freeze
    BANKTRANS  = "BANKTRANS".freeze
    BELFIUS    = "BELFIUS".freeze
    SANTANDER  = "SANTANDER".freeze
    KBC        = "CBC / KBC".freeze
    CREDITCARD = "CREDITCARD".freeze
    DOTPAY     = "DOTPAY".freeze
    EDENCOM    = "EDENCOM".freeze
    EINVOICE   = "EINVOICE".freeze
    EPS        = "EPS".freeze
    GIROPAY    = "GIROPAY".freeze
    GOOGLEPAY  = "GOOGLEPAY".freeze
    IDEAL      = "IDEAL".freeze
    IDEALQR    = "IDEALQR".freeze
    IN3        = "IN3".freeze
    KLARNA     = "KLARNA".freeze
    MAESTRO    = "MAESTRO".freeze
    MASTERCARD = "MASTERCARD".freeze
    MBWAY      = "MBWAY".freeze
    MULTIBANCO = "MULTIBANCO".freeze
    MYBANK     = "MYBANK".freeze
    BNPL_MF    = "BNPL_MF".freeze
    BNPL_INSTM = "BNPL_INSTM".freeze
    PAYPAL     = "PAYPAL".freeze
    PSAFECARD  = "PSAFECARD".freeze
    DBRTP      = "DBRTP".freeze
    AFTERPAY   = "AFTERPAY".freeze
    DIRDEB     = "DIRDEB".freeze
    DIRECTBANK = "DIRECTBANK".freeze
    TRUSTLY    = "TRUSTLY".freeze
    TRUSTPAY   = "TRUSTPAY".freeze
    VISA       = "VISA".freeze
    WECHAT     = "WECHAT".freeze
    ZINIA      = "ZINIA".freeze

    # Giftcards
    AMSGIFT    = "AMSGIFT".freeze
    BABYCAD    = "BABYCAD".freeze
    BEAUTYWELL = "BEAUTYWELL".freeze
    BLOEMENCAD = "BLOEMENCAD".freeze
    BOEKENBON  = "BOEKENBON".freeze
    DEGROTESPL = "DEGROTESPL".freeze
    DORDTPAS   = "DORDTPAS".freeze
    EDENCO     = "EDENCO".freeze  
    EDENRES    = "EDENRES".freeze
    EDENSPORTS = "EDENSPORTS".freeze
    FASHIONCHQ = "FASHIONCHQ".freeze
    FASHIONGFT = "FASHIONGFT".freeze
    FIETSENBON = "FIETSENBON".freeze
    GELREPAS   = "GELREPAS".freeze
    GEZONDHEID = "GEZONDHEID".freeze
    GOOD4FUN   = "GOOD4FUN".freeze
    HORSESGIFT = "HORSESGIFT".freeze
    MONIECO    = "MONIECO".freeze
    MONIGIFT   = "MONIGIFT".freeze
    MONIMEAL   = "MONIMEAL".freeze
    NATNLBIOSC = "NATNLBIOSC".freeze
    NATNLETUIN = "NATNLETUIN".freeze
    PARFUMCADE = "PARFUMCADE".freeze
    ROTGIFT    = "ROTGIFT".freeze
    UPAS       = "UPAS".freeze
    SPORTENFIT = "SPORTENFIT".freeze
    SODESPORTS = "SODESPORTS".freeze
    VRGIFTCARD = "VRGIFTCARD".freeze
    VVVGIFTCRD = "VVVGIFTCRD".freeze
    WEBSHOPGFT = "WEBSHOPGFT".freeze
    WIJNCADEAU = "WIJNCADEAU".freeze
    YOURGIFT   = "YOURGIFT".freeze

    attr_accessor :id,
                  :description

    def self.all_available(options = {})
      response = Client.instance.get("gateways", nil, options)
      MultiSafePay::List.new(response, MultiSafePay::Method)
    end
  end
end
