# Solidus + EasyPost

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


## Usage

This extension hijacks `Spree::Stock::Estimator#shipping_rates` to calculate shipping rates for your orders. This call happens during the checkout process, once the order's address information has been provided.
The extension also adds a callback to the "ship" event on the `Shipment` model, telling EasyPost which rate was selected and "buying" that rate. This can be disabled by setting:

```ruby
  # config/initializers/easy_post.rb
  Spree::EasyPost::configs[:purchase_labels?] = false
```

This gem will create shipping methods for each type of carrier/service for which it receives a rate from the EasyPost API. These are set to  `display_on: back_end` by default and must be set to `front_end`
or `both` before the rate will be visible on the delivery page of the checkout.

## Getting Started

Some easy mistakes to run into when initially setting up this gem are:
- EasyPost requires that packages have a weight. Ensure that variants have a non
  zero weight value.
- EasyPost performs address validation on addresses. Ensure the order
  ship_address and stock location address are valid addresses.
- This Gem currently looks for shipping methods which have admin names which
  match the pattern `<Carrier Name> <Service Level>`. If it cant find an
  existing match, a new shipping method is created with `display_on=:backend`.
  The first order placed may receive a message of no "shipping rates found".
  Check if new Shipping Methods were created in the admin `Settings>Shipping`
  section, and ensure at least one shipping method is `display_on=<:both or :frond_end>`

## Compatibility

Although the goal is for every version of this gem to be compatible with every
version of Solidus. It is possible for Solidus to introduce breaking changes
which make older versions of this gem incompatible with newer versions of Solidus.
We will make sure to patch old versions to remain compatible with supported
versions of Solidus.

|solidues_easypost version|Compatible up to solidus version|
|---|---|
|v1.0.2|< v1.3.0|
|v1.0.3|master|

## Issues

Please let me know if you find any issues in [the usual places](https://github.com/solidusio-contrib/solidus_easypost/issues), with [the usual information](https://github.com/solidusio/solidus/blob/master/CONTRIBUTING.md).

