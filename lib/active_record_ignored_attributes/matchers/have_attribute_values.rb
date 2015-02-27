RSpec::Matchers.define :have_attribute_values do |expected|
  match do |actual|
    actual.has_attribute_values?(expected)
  end

  failure_message do |actual|
    %(expected: #{expected.symbolize_keys.inspect}\n) +
    %(     got: #{actual.attributes.slice(*expected.stringify_keys.keys).symbolize_keys.inspect})
  end

  failure_message_when_negated do |actual|
    %(expected #{actual.inspect}\n) +
    %(not to have attribute values #{expected.symbolize_keys.inspect})
  end
end
