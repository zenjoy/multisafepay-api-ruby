module MultiSafePay
  class List < Base
    include Enumerable

    attr_accessor :klass, :items, :pager

    def initialize(list_attributes, klass)
      @klass = klass
      @pager = list_attributes['pager'] || {}

      list_attributes['items'] ||= list_attributes['data'] || []
      super list_attributes

      @items = items.map do |attributes|
        klass.new attributes
      end
    end

    def [](index)
      @items[index]
    end

    def size
      @items.size
    end

    def each(&block)
      @items.each(&block)
    end

    def next?
      !pager['after'].nil?
    end

    def previous?
      !pager['before'].nil?
    end

    def next(options = {})
      return self.class.new({}, klass) if pager['after'].nil?

      href = URI.parse(pager['after'])
      query = URI.decode_www_form(href.query).to_h

      response = MultiSafePay::Client.instance.perform_http_call('GET', pager['after'], nil, {}, options.merge(query))
      self.class.new(response, klass)
    end

    def previous(options = {})
      return self.class.new({}, klass) if pager['before'].nil?

      href = URI.parse(pager['before'])
      query = URI.decode_www_form(href.query).to_h

      response = MultiSafePay::Client.instance.perform_http_call('GET', pager['before'], nil, {}, options.merge(query))
      self.class.new(response, klass)
    end
  end
end
