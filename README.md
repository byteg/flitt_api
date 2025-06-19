# FlittAPI Ruby Client

This gem provides a simple interface to interact with Flitt.com payment API.

## Installation

```sh
gem install flitt_api
```

## Usage

```ruby
require 'flitt_api'

client = FlittAPI::Client.new(api_key: 'your-secret-key')

# Create a payment
payment = client.create_payment(amount: 1000, currency: 'USD', customer_id: 'cus_123')

# Retrieve a payment
payment = client.get_payment(payment["id"])

# List all payments
payments = client.list_payments
```

## Running Tests

```sh
bundle install
rspec
```
