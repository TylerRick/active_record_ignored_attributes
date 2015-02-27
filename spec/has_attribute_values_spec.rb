require 'spec_helper'

describe Address do
  describe 'has_attribute_values?' do
    let(:address) { Address.new }

    it 'should return true if passed {}' do
      a = Address.new(        name: 'A', address: 'The Same Address', city: "Don't care")
      expect(a.has_attribute_values?({})).to be(true)
    end

    it 'should return true if the given attributes have the given values' do
      a = Address.new(        name: 'A', address: 'The Same Address', city: "Don't care")
      expect(a.has_attribute_values?(name: 'A', address: 'The Same Address')).to be(true)
    end

    it 'should return false if any of the given attributes have different values than given' do
      a = Address.new(        name: 'A', address: 'The Same Address', city: "Don't care")
      expect(a.has_attribute_values?(name: 'A', address: 'The Same Address', city: "I do care after all")).to be(false)
      expect(a.has_attribute_values?(name: 'B', address: 'The Same Address')).to be(false)
    end
  end
end

