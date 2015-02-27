require "spec_helper"
require 'active_support/core_ext/string/strip'

describe "be_same_as" do
  it "delegates to same_as?" do
    object, other = Object.new, Object.new
    mock(object).same_as?(other) { true }
    expect(object).to be_same_as(other)
  end

  it "reports a nice failure message for to" do
    object, other = Address.new(address: 'A Street'), Address.new(address: 'B Street')
    expect do
      expect(object).to be_same_as(other)
    end.to raise_error(<<-End.strip_heredoc.chomp)
    expected: #<Address address: "B Street">
         got: #<Address address: "A Street">
    End
  end

  it "reports a nice failure message for to_not" do
    object, other = Address.new(address: 'A Street'), Address.new(address: 'A Street')
    expect do
      expect(object).to_not be_same_as(other)
    end.to raise_error(<<-End.strip_heredoc.chomp)
         expected: {Address id: nil, name: nil, address: "A Street", city: nil, state: nil, postal_code: nil, country: nil}
to not be same_as: {Address id: nil, name: nil, address: "A Street", city: nil, state: nil, postal_code: nil, country: nil}
    End
  end
end
