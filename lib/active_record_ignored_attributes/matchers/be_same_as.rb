RSpec::Matchers.define :be_same_as do |expected|
  match do |actual|
    actual.same_as?(expected)
  end

  failure_message_for_should do |actual|
   #%(#{actual.inspect_without_ignored_attributes} was expected to have the same attributes as\n) +
   #%(#{expected.inspect_without_ignored_attributes})

    attr_names_that_differed = actual.attributes_without_ignored_attributes.select do |k,v|
      expected[k] != v
    end.map(&:first)
    # TODO: pass extra option to inspect_with (such as the other object) so that it can use the same width for each attribute so that they line up nicely and are easy to visually compare
    %(expected: #{expected.inspect_with(attr_names_that_differed)}\n) +
    %(     got: #{actual.inspect_with(attr_names_that_differed)})
  end

  failure_message_for_should_not do |actual|
    %(         expected: #{expected.inspect}\n) +
    %(to not be same_as: #{actual.inspect})
  end
end
