# frozen_string_literal: true

module SolidusEasypost
  class VerifiableAddress
    include ActiveModel::Model
    attr_accessor :street1
    attr_accessor :street2
    attr_accessor :city
    attr_accessor :name
    attr_accessor :company
    attr_accessor :state
    attr_accessor :country
    attr_accessor :zip
    attr_accessor :phone

    validates :street1, presence: true

    validates :city, presence: true
    validates :state, presence: true

    validates :zip, presence: true

    validate :no_easypost_verification_errors

    def memo_hash
      join %i[street1 street2 city zip phone]
    end

    # Coerce model params to easypost format
    # {:name=>"John Doe", :company=>"Company",
    #   :street1=>"A Different Road", :street2=>"Northwest",
    #   :city=>"Manville", :state=>"NJ", :zip=>"08835",
    #   :country=>"US", :phone=>"555-555-0199"}
    def easypost_params
      attrs = %i[name company street1 street2 city state zip country phone]
      attrs.map { |attr_name| [attr_name, send(attr_name)] }
          .to_h
          .merge(verify: verification_params )
    end

    def no_easypost_verification_errors
      verifications.each do |key, value|
        unless value.try(:success)
          errors.add :base, "EasyPost address verification failure response: [#{value}]. What we sent: [#{easypost_params}]"
        end
      end
    end

    def to_easypost
      @to_easypost ||= begin
                     ::EasyPost::Address.create easypost_params
                   rescue ::EasyPost::Error => e
                     errors.add :base, "EasyPost address verification failure response: [#{e.message}]. What we sent: [#{easypost_params}]"
                   end
    end

    def verifications
      verification_params.map do |field|
        [field, to_easypost.verifications.try(field)]
      end
    end

    def self.from_stock_location(stock_location); end

    def self.from_ship_address(addr)
      new(
          company: addr.company,
          name: addr&.name || addr&.full_name,
          state: addr.state&.abbr || addr.state_name,
          country: addr&.country&.iso,
          street1: addr&.address1.to_s,
          street2: addr&.address2.to_s,
          city: addr.city,
          zip: addr.zipcode,
          phone: addr.phone
      )
    end

    private

    def verification_params
      %w[delivery zip4]
    end

    def should_verify?
      #::Spree::Easypost::Config.address_verification_enabled
      true
    end

  end
end
