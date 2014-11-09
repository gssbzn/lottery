require 'test_helper'

class SubscriberTest < ActiveSupport::TestCase

  test "should save valid subscriber" do
    subscriber = Subscriber.new
    subscriber.email = 'test@test.com'
    assert subscriber.save, "Invalid subscriber"
  end

  test "should not save subscriber without email" do
    subscriber = Subscriber.new
    assert_not subscriber.save
  end

  test "should not save subscriber without valid email" do
    subscriber = Subscriber.new
    subscriber.email = 'test'
    assert_not subscriber.save
  end

  test "should not save duplicated subscriber" do
    subscriber1 = subscribers(:test_one)
    subscriber2 = Subscriber.new email: subscriber1.email
    assert_not subscriber2.valid?, "Duplicated subscriber"
  end

end
