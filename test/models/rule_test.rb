require 'test_helper'

class RuleTest < ActiveSupport::TestCase
  test "should save valid rule (number)" do
    prize = prizes(:nexus)
    rule = Rule.new name: 'Test', prize: prize, participant_number: 1
    assert rule.save, "Can't save valid rule"
  end
  
  test "should save valid rule (multiple)" do
    prize = prizes(:nexus)
    rule = Rule.new name: 'Test', prize: prize, participant_number_multiple: 2
    assert rule.save, "Can't save valid rule"
  end
  
  test "should not save empty name" do    
    prize = prizes(:nexus)
    rule = Rule.new prize: prize, participant_number: 1
    assert_not rule.save, "Saves rule without name"
  end
  
  test "should not save empty prize" do    
    rule = Rule.new name: 'Test', participant_number: 1
    assert_not rule.save, "Saves rule without prize"
  end
  
  test "should not save empty participant number or multiple" do    
    prize = prizes(:nexus)
    rule = Rule.new name: 'Test', prize: prize
    assert_not rule.save, "Saves rule without conditions"
  end
end
