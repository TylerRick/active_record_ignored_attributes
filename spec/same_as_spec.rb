require 'spec_helper'

describe Address do
  describe 'same_as?' do
    let(:address) { Address.new }

    it 'should return false even if any of the non-ignored attributes differ' do
      a = Address.new(address: '123 A Street')
      b = Address.new(address: '345 K Street')

      expect(a).to_not be_same_as(b)
      expect(a.attributes).to_not eq(b.attributes)
      expect(a.attributes_without_ignored_attributes).to_not eq(b.attributes_without_ignored_attributes)
    end

    it 'should still return true even if some of the ignored attributes differ' do
      a = Address.new(name: 'A', address: 'The Same Address')
      b = Address.new(name: 'B', address: 'The Same Address')

      expect(a).to be_same_as(b)
      expect(a.attributes).to_not eq(b.attributes)
      expect(a.attributes_without_ignored_attributes).to eq(b.attributes_without_ignored_attributes)
    end
  end
end
