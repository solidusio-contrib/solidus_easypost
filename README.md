# Solidus + EasyPost

[![CircleCI](https://circleci.com/gh/boomerdigital/solidus_easypost.svg?style=svg)](https://circleci.com/gh/boomerdigital/solidus_easypost)

This is an extension to integrate Easy Post into Spree. Due to how it works, you will not be able to use any other extension than this for shipping methods. Your own shipping methods will not work, either. But the good thing is that you won't have to worry about that, because Easy Post handles it all for you.

You will need to [sign up for an account](https://www.easypost.com/) to use this extension.

## Installation

This goes in your `Gemfile`:
```ruby
  gem 'solidus_easypost'
```

This goes in your terminal:
```ruby
  rake railties:install:migrations
  rake db:migrate
```

This goes into a new file called `config/initializers/easy_post.rb`:
```ruby
  EasyPost.api_key = 'YOUR_API_KEY_HERE'
```

To enable DDP, place this in the file `config/initializers/easy_post.rb`:
```ruby
  Spree::Easypost::Config.ddp_enabled = true
```

We also have the below configurations available.
```ruby
Spree::Easypost::Config.api_enabled = true # default
Spree::Easypost::Config.address_verification_enabled = false # default
Spree::Easypost::Config.verify_strict_enabled = false # default
```

## Usage

This extension hijacks `Spree::Stock::Estimator#shipping_rates` to calculate shipping rates for your orders. This call happens during the checkout process, once the order's address information has been provided.
The extension also adds a callback to the "ship" event on the `Shipment` model, telling EasyPost which rate was selected and "buying" that rate. This can be disabled by setting:

```ruby
  # config/initializers/easy_post.rb
  Solidus::EasyPost::CONFIGS[:purchase_labels?] = false
```

This gem will create shipping methods for each type of carrier/service for which it receives a rate from the EasyPost API. These are set to  `display_on: back_end` by default and must be set to `front_end`
or `both` before the rate will be visible on the delivery page of the checkout.

## Issues

Please let me know if you find any issues in [the usual places](https://github.com/solidusio-contrib/solidus_easypost/issues), with [the usual information](https://github.com/solidusio/solidus/blob/master/CONTRIBUTING.md).
