require 'test_helper'

class PrizeTest < ActiveSupport::TestCase
  
  test "should save valid prize" do
    prize = Prize.new name: 'Test'
    assert prize.save, "Invalid prize"
  end

  test "should not save prize without name" do
    prize = Prize.new
    assert_not prize.save, "Empty name"
  end
  
   test "should not save duplicated prize" do
    prize1 = prizes(:nexus)
    prize2 = Prize.new name: prize1.name
    assert_not prize2.valid?, "Duplicated prize"
  end
end
