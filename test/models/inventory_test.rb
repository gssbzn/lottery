require 'test_helper'

class InventoryTest < ActiveSupport::TestCase
  test "should save valid inventory" do
    prize = prizes(:nexus)
    inventory = Inventory.new qty_available: 100, inventariable: prize
    assert inventory.save, "Invalid inventory"
  end

  test "should not save empty inventory" do
    inventory = Inventory.new
    assert_not inventory.save, "Empty inventory"
  end
  
  test "should not save inventory without inventariable" do
    inventory = Inventory.new qty_available: 100
    assert_not inventory.save, "Invalid inventory"
  end
  
  test "should not save inventory with invalid qty" do
    prize = prizes(:nexus)
    inventory = Inventory.new qty_available: 'aa', inventariable: prize
    assert_not inventory.save, "Invalid inventory"
  end
  
  test "should not save duplicated inventory" do
    #prize = prizes(:tv)
    inventory1 = inventories(:tv)
    inventory2 = Inventory.new qty_available: 100, inventariable: inventory1.inventariable
    assert_not inventory2.valid?, "Duplicated inventory"
  end
  
end
