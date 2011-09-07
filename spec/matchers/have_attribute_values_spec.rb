require 'pathname'; __DIR__ = Pathname.new(__FILE__).dirname
require __DIR__ + "../spec_helper"
require 'active_support/core_ext/string/strip'

describe "have_attribute_values" do
  it "delegates to has_attribute_values?" do
    object, other = Object.new, Object.new
    mock(object).has_attribute_values?(other) { true }
    object.should have_attribute_values(other)
  end

  it 'matches when it should match' do
    object = Address.new(                 name: 'A', address: 'The Same Address', city: "Don't care")
    expect do
      (object.should have_attribute_values name: 'A', address: 'The Same Address').should be_true
    end.to_not raise_error
  end

  it "reports a nice failure message for should" do
    object = Address.new(                 name: 'A', address: 'The Same Address', city: "Don't care")
    expect do
      object.should have_attribute_values name: 'A', address: 'A Slightly Different Address'
    end.to raise_error(<<-End.strip_heredoc.chomp)
    expected: {:name=>"A", :address=>"A Slightly Different Address"}
         got: {:name=>"A", :address=>"The Same Address"}
    End
  end

  it "reports a nice failure message for should_not" do
    object = Address.new(                 name: 'A', address: 'The Same Address', city: "Don't care")
    expect do
      object.should_not have_attribute_values name: 'A', address: 'The Same Address'
    end.to raise_error(<<-End.strip_heredoc.chomp)
    expected {Address id: nil, name: "A", address: "The Same Address", city: "Don't care", state: nil, postal_code: nil, country: nil}
    not to have attribute values {:name=>"A", :address=>"The Same Address"}
    End
  end
end
