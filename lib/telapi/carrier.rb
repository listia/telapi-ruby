module Telapi
  # Wraps TelAPI Carrier functionality
  class Carrier < Resource
    class << self

      # Returns a resource collection containing Telapi::Carrier objects
      # See http://docs.telapi.com/v2/docs/carrier-lookup-list
      #
      # Optional params is a hash containing:
      # +Page+:: integer greater than 0
      # +PageSize+:: integer greater than 0
      def list(optional_params = {})
        response = Network.get(['Lookups', 'Carrier'], optional_params)
        ResourceCollection.new(response, 'carrier_lookups', self)
      end

      # Returns a Telapi::Carrier object given a phone number
      # See http://docs.telapi.com/v2/docs/carrier-lookup
      def lookup(phone_number)
        opts = { :PhoneNumber => phone_number }
        response = Network.post(['Lookups','Carrier'], opts)
        Carrier.new(response)
      end

    end
  end
end
