module ActiveRecordIgnoredAttributes::SameAttributesAs
  def same_attributes_as?(other)
    self. attributes_without_ignored_attributes ==
    other.attributes_without_ignored_attributes
  end
  alias_method :same_as?, :same_attributes_as?
end
