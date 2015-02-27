require 'spec_helper'

describe Address do
  describe 'inspect_without_ignored_attributes' do
    let(:address) { Address.create }
    it "should include id" do
      expect(address.inspect_without_ignored_attributes).to match(/id:/)
    end
    it "should not include the other ignored_attributes" do
      expect(address.inspect_without_ignored_attributes).to_not match(/name:/)
      expect(address.inspect_without_ignored_attributes).to_not match(/created_at:/)
    end
    it "should match what we expect it to look like" do
      m = /Addressid:\d+, address:nil, city:nil, country:nil, postal_code:nil, state:nil/
      expect(address.inspect_without_ignored_attributes.gsub(/[<>#]/,'').gsub(/\s/, '').split(/,/).sort.to_s.gsub(/["\]\[]/,'')).to match(m)
      expect(address.original_inspect).to match(/#<Address id: \d+, .* created_at: ".*", updated_at: ".*">/)
    end
  end

  describe 'inspect' do
    let(:address) { Address.create }
    specify do
      expect(address.inspect).to match(/{Address id: \d+, name: nil, address: nil, city: nil, state: nil, postal_code: nil, country: nil}/)
    end
  end
end
