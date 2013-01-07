# Adds assertions that compare records excluding ignored attributes.

module ActiveRecordIgnoredAttributes::Testing
  module Assertions extend ActiveSupport::Concern

    def assert_same_attributes_as(expected, actual)
      assert_equal expected.attributes_without_ignored_attributes,
        actual.attributes_without_ignored_attributes
    end

    alias_method :assert_same_as, :assert_same_attributes_as
  end
end
