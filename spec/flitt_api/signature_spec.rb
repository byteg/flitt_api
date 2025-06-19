# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FlittAPI::Signature do
  let(:secret_key) { 'test' }
  let(:signature) { described_class.new(secret_key: secret_key, params: params) }

  it 'generates correct signature' do
    params = { server_callback_url: 'http://myshop/callback/', order_id: 'TestOrder2', currency: 'GEL', merchant_id: '1549901', order_desc: 'Test payment', amount: 1000 }
    signature = described_class.new(secret_key: secret_key, params: params)

    expect(signature.call).to eq('cd0edb710cbbdb6c2a4d965cdb91fdfabc343215')
  end

  it 'generates correct signature with blank params' do
    params = { server_callback_url: 'http://myshop/callback/', order_id: 'TestOrder2', blank: '', currency: 'GEL', merchant_id: '1549901', order_desc: 'Test payment', amount: 1000 }
    signature = described_class.new(secret_key: secret_key, params: params)

    expect(signature.call).to eq('cd0edb710cbbdb6c2a4d965cdb91fdfabc343215')
  end

  it 'excludes signature field from signature generation' do
    params = { server_callback_url: 'http://myshop/callback/', order_id: 'TestOrder2', signature: '1234567890', currency: 'GEL', merchant_id: '1549901', order_desc: 'Test payment', amount: 1000 }
    signature = described_class.new(secret_key: secret_key, params: params)

    expect(signature.call).to eq('cd0edb710cbbdb6c2a4d965cdb91fdfabc343215')
  end
end