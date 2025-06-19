# FlittAPI Ruby Client

This gem provides a simple interface to interact with Flitt.com payment API.

## Installation

```sh
gem install flitt_api
```

## Usage

```ruby
require 'flitt_api'

client = FlittAPI::Client.new(secret_key: 'test', merchant_id: 1549901) # test merchant data

# Create a payment
checkout = client.generate_checkout_url(amount: 1000,
                                        currency: 'USD',
                                        order_id: 'MyFirstOrder',
                                        order_desc: 'Test payment',
                                        server_callback_url: 'http://myshop/callback/')
checkout['checkout_url'] # redirect user to this URL to make a payment
```

## Running Tests

```sh
bundle install
rspec
```
