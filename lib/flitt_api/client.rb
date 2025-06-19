# frozen_string_literal: true

require 'faraday'
require 'json'

module FlittAPI
  class Client
    API_BASE = 'https://api.flitt.com/v1'

    attr_reader :api_key, :conn

    def initialize(api_key:)
      @api_key = api_key
      @conn = Faraday.new(url: API_BASE) do |faraday|
        faraday.request :json
        faraday.response :json
        faraday.adapter Faraday.default_adapter
        faraday.headers['Content-Type'] = 'application/json'
        faraday.headers['Accept'] = 'application/json'
      end
    end

    def create_payment(amount:, currency:, customer_id:)
      post('/payments', {
        amount: amount,
        currency: currency,
        customer_id: customer_id
      })
    end

    def get_payment(payment_id)
      get("/payments/\#{payment_id}")
    end

    def list_payments
      get('/payments')
    end

    private

    def get(path)
      response = conn.get(path)
      handle_response(response)
    end

    def post(path, body)
      response = conn.post(path, body)
      handle_response(response)
    end

    def handle_response(response)
      if response.success?
        response.body
      else
        raise Error.new(response.body['error'] || 'Unknown error', response.status)
      end
    end

    class Error < StandardError
      attr_reader :status_code

      def initialize(message, status_code)
        super(message)
        @status_code = status_code
      end
    end
  end
end
