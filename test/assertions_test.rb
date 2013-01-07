require "test_helper"

class AssertionsTest < ActiveSupport::TestCase
  test "assert_same_as succeeds if only ignored attributes differ" do
    a = Address.new(name: 'A', address: 'The Same Address')
    b = Address.new(name: 'B', address: 'The Same Address')
    assert_same_as a, b
  end

  test "assert_same_as fails if attributes other than ignored ones differ" do
    a = Address.new(name: 'A', address: 'Some Address')
    b = Address.new(name: 'B', address: 'Another Address')
    begin
      assert_same_as a, b
    rescue Exception => e
      # Note: Not using assert_raise because we don't exactly know which exception
      # will be raised (depends on whether MiniTest is used under the hood).
      # Rescuing Exception is ugly, so we at least look whether the failure
      # message has an ok shape.
      assert_match /Some Address/, e.message
      assert_match /Another Address/, e.message
    end
  end
end
