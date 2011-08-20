class Address < ActiveRecord::Base
  alias_method :original_inspect, :inspect

  def inspect
    inspect_with([:id, :name, :address, :city, :state, :postal_code, :country], ['{', '}'])
  end

  def self.ignored_attributes
    super + [:name]
  end
end
