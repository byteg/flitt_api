# frozen_string_literal: true

require 'spec_helper'
require 'webmock/rspec'

RSpec.describe FlittAPI::Client do
  let(:api_key) { 'test_key' }
  let(:client) { described_class.new(api_key: api_key) }

  it 'creates a payment' do
    stub_request(:post, "https://api.flitt.com/payments").
         with(
           body: "{\"amount\":1000,\"currency\":\"USD\",\"customer_id\":\"cus_123\"}",
           headers: {
       	  'Accept'=>'application/json',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'Content-Type'=>'application/json',
       	  'User-Agent'=>'Faraday v2.13.1'
           })
      .to_return(status: 200, body: { id: "pay_123", amount: 1000 }.to_json, headers: { 'Content-Type' => 'application/json' })

    result = client.create_payment(amount: 1000, currency: 'USD', customer_id: 'cus_123')
    expect(result['id']).to eq('pay_123')
  end
end