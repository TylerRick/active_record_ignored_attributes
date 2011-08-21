require 'facets/string/bracket'

module ActiveRecordIgnoredAttributes::Inspect

  # TODO: brackets = self.class.default_brackets_for_inspect (configurable via class_inheritable_accessor)

  def inspect_with(attr_names, brackets = ['#<', '>'])
    attr_names ||= id
    body = attr_names.map {|name|
      "#{name}: #{send(name).inspect}"
    }.join(', ')

    "#{self.class} #{body}".
      bracket(*brackets)
  end

  def attributes_for_inspect
    [:id].map(&:to_s) + 
    (attributes.keys - self.class.ignored_attributes.map(&:to_s))
  end

  def inspect_without_ignored_attributes
    inspect_with(attributes_for_inspect)
  end
end
