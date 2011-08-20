require 'spec_helper'

describe Address do
  describe 'attributes_without_ignored_attributes' do
    let(:address) { Address.create! }
    it 'should not include any of the ignored attributes' do
      address.attributes_without_ignored_attributes.tap do |attributes|
        attributes.should be_a(Hash)
        attributes.should_not have_key('id')
        attributes.should_not have_key('created_at')
        attributes.should_not have_key('updated_at')
        attributes.should_not have_key('name')
      end

      # Plain old 'attributes', on the other hand, does include them
      address.attributes.tap do |attributes|
        attributes.should be_a(Hash)
        attributes.should have_key('id')
        attributes.should have_key('created_at')
        attributes.should have_key('updated_at')
      end
    end

    it 'should include all of the non-ignored attributes' do
      address.attributes_without_ignored_attributes.tap do |attributes|
        attributes.should be_a(Hash)
        [:address, :city, :state, :postal_code, :country].each do |attr_name|
          #puts "attributes.has_key?(#{attr_name})=#{attributes.has_key?(attr_name)}"
          attributes.should have_key(attr_name.to_s)
        end
      end
    end
  end
end
