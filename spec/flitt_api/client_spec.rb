# frozen_string_literal: true

require 'spec_helper'
require 'pry'

RSpec.describe FlittAPI::Client do
  let(:secret_key) { 'test' }
  let(:merchant_id) { 1549901 }
  let(:client) { described_class.new(merchant_id: merchant_id, secret_key: secret_key) }

  it 'generates checkout url' do
    VCR.use_cassette('generate_checkout_url') do
      result = client.generate_checkout_url(amount: 1000, currency: 'USD', order_id: 'ByteTestOrder207', order_desc: 'Test payment', server_callback_url: 'http://myshop/callback/')
      expect(result['checkout_url']).to eq('https://pay.flitt.com/merchants/6aa79957f6f8336b820e6c82b7634f0c/default/index.html?token=abb4517911ccb496b3a175df8ecb040d48d0cfb4')
    end
  end
end