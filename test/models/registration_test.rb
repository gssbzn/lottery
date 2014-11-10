require 'test_helper'

class RegistrationTest < ActiveSupport::TestCase
  test "should save valid registration" do
    registration = Registration.new
    registration.subscriber = subscribers(:subscriber_1)
    assert registration.save, "Invalid registration"
  end

  test "should not save registration without subscriber" do
    registration = Registration.new
    assert_not registration.save, "Empty subscriber"
  end

  test "should not save more than one registration per subscriber by day" do
    registration1 = registrations(:registration_1)
    registration2 = Registration.new subscriber: registration1.subscriber, created_at: registration1.created_at
    assert_not registration2.save, "Duplicated registration"
  end

  test "should save more than one registration per subscriber by different day" do
    registration1 = registrations(:registration_1)
    registration2 = Registration.new subscriber: registration1.subscriber
    assert registration2.save, "Invalid registration"
  end
  
#  test "prize assigment" do 
#    third = subscribers(:test_three)
#    registration = Registration.new subscriber: third
#    assert registration.save, "Invalid registration"
#    subs4 = subscribers(:subscriber_4)
#    registration = Registration.new subscriber: subs4
#    assert registration.save, "Invalid registration"
#  end
end
