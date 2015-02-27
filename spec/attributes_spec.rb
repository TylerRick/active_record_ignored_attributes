require 'spec_helper'

describe Address do
  describe 'attributes_without_ignored_attributes' do
    let(:address) { Address.create! }
    it 'should not include any of the ignored attributes' do
      address.attributes_without_ignored_attributes.tap do |attributes|
        expect(attributes.class).to eq(Hash)
        expect(attributes).to_not have_key('id')
        expect(attributes).to_not have_key('created_at')
        expect(attributes).to_not have_key('updated_at')
        expect(attributes).to_not have_key('name')
      end

      # Plain old 'attributes', on the other hand, does include them
      address.attributes.tap do |attributes|
        expect(attributes.class).to eq(Hash)
        expect(attributes).to have_key('id')
        expect(attributes).to have_key('created_at')
        expect(attributes).to have_key('updated_at')
      end
    end

    it 'should include all of the non-ignored attributes' do
      address.attributes_without_ignored_attributes.tap do |attributes|
        expect(attributes.class).to eq(Hash)
        [:address, :city, :state, :postal_code, :country].each do |attr_name|
          #puts "attributes.has_key?(#{attr_name})=#{attributes.has_key?(attr_name)}"
          expect(attributes).to have_key(attr_name.to_s)
        end
      end
    end
  end
end
