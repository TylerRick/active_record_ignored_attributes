require 'spec_helper'

describe Address do
  describe 'inspect_without_ignored_attributes' do
    let(:address) { Address.create }
    it do
      address.inspect_without_ignored_attributes.should_not match(/id:/)
      address.inspect_without_ignored_attributes.should_not match(/name:/)
      address.inspect_without_ignored_attributes.should_not match(/created_at:/)
      address.original_inspect.should                match(/#<Address id: \d+, .* created_at: ".*", updated_at: ".*">/)
      address.inspect_without_ignored_attributes.should == "#<Address address: nil, city: nil, country: nil, postal_code: nil, state: nil>"
    end
  end

  describe 'inspect' do
    let(:address) { Address.create }
    it do
      address.inspect.should match(/{Address id: \d+, name: nil, address: nil, city: nil, state: nil, postal_code: nil, country: nil}/)
    end
  end
end
