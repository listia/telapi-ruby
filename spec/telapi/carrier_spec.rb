require 'spec_helper'

describe Telapi::Carrier do
  before do
    stub_telapi_request
    set_account_sid_and_auth_token
  end

  it { should be_kind_of(Telapi::Resource) }

  describe ".list" do
    before { stub_telapi_request('{ "carrier_lookups": [] }') }

    it "calls api via http get and returns a ResourceCollection" do
      api_should_use(:get)
      klass.list.should be_a(Telapi::ResourceCollection)
    end

    context "when Carrier lookups exist" do
      before { stub_telapi_request('{ "carrier_lookups": [{ "phone_number": "+17325551234" }] }') }

      it "has a collection of Carrier Lookup objects" do
        klass.list.first.should be_a(klass)
      end
    end
  end

  describe ".lookup" do
    it "calls api via http post and returns a Carrier resource" do
      api_should_use(:post)
      klass.lookup('17325551234').should be_a(klass)
    end
  end
end
