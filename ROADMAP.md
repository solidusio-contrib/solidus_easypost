# That Which Is To Come
_Ordered bottom to top_

## June 15th, 2016
- Release 1.1.0
    - Solidus 1.x compatible
    - Respect `Spree::ShippingMethod.available_for_address`
    - Finds shipping methods for easy post rates on `carrier` and `service_level` fields
    - Deprecate all of the module prepended methods
    - provide alternatives to module prepended methods with gem specific service classes wrapping Solidus (Spree) objects
    - Use pluggable estimator class
    - Set correct tax rates on shipping rates following [core](https://github.com/solidusio/solidus/blob/796ed7fa49e793360a1b47b6df03a7bc2a116ccf/core/app/models/spree/stock/estimator.rb#L33)
    - provide alternatives to module prepended methods with gem specific service classes wrapping Solidus (Spree) objects
    - Use pluggable estimator class

- Bugfixes will continue for 1.0.x

- Release 1.0.4 with named VCR cassetes
    - current versions of this gem are not compatible with that change.

- Release 1.0.3 with compatibility for solidus 1.3+
    - The signature for the Stock::Estimator initialization method was changed.
