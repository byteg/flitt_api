# frozen_string_literal: true

require 'faraday'
require 'json'

module FlittAPI
  class Client
    API_BASE = 'https://pay.flitt.com/api'

    attr_reader :merchant_id, :secret_key, :conn

    def initialize(merchant_id:, secret_key:, api_url: API_BASE)
      @conn = Connection.new(api_url: api_url)
      @merchant_id = merchant_id
      @secret_key = secret_key
    end

    def generate_checkout_url(amount:, currency:, order_id:, order_desc:, server_callback_url:)
      params = {
        server_callback_url: server_callback_url,
        order_id: order_id,
        currency: currency,
        merchant_id: merchant_id,
        order_desc: order_desc,
        amount: amount
      }
      params[:signature] = Signature.new(secret_key: secret_key, params: params).call
      conn.post('/api/checkout/url', params)
    end
  end
end
