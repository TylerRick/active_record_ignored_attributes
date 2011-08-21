require 'spec_helper'

describe Address do
  describe 'inspect_without_ignored_attributes' do
    let(:address) { Address.create }
    it "should include id" do
      address.inspect_without_ignored_attributes.should     match(/id:/)
    end
    it "should not include the other ignored_attributes" do
      address.inspect_without_ignored_attributes.should_not match(/name:/)
      address.inspect_without_ignored_attributes.should_not match(/created_at:/)
    end
    it "should match what we expect it to look like" do
      address.inspect_without_ignored_attributes.should match(/#<Address id: \d+, address: nil, city: nil, country: nil, postal_code: nil, state: nil>/)
      address.original_inspect.should                   match(/#<Address id: \d+, .* created_at: ".*", updated_at: ".*">/)
    end
  end

  describe 'inspect' do
    let(:address) { Address.create }
    specify do
      address.inspect.should match(/{Address id: \d+, name: nil, address: nil, city: nil, state: nil, postal_code: nil, country: nil}/)
    end
  end
end
