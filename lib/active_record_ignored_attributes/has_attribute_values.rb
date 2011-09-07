#require 'active_support/core_ext/hash/keys'

module ActiveRecordIgnoredAttributes::HasAttributeValues
  def has_attribute_values?(expected)
    self.attributes.slice(*expected.stringify_keys.keys) == expected.stringify_keys
  end
  alias_method :has_attributes_hash?, :has_attribute_values?
end

