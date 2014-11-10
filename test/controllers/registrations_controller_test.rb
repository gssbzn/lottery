require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  test "should create registration" do
    assert_difference('Registration.count') do
      post :create, registration: {email: 'test@test.com'}
    end
    assert_redirected_to root_path    
  end

  test "should not create registration with invalid email" do
    assert_no_difference('Registration.count') do
      post :create, registration: {email: 'test'}
    end
    assert_redirected_to root_path
    assert_not_nil flash[:error]
  end
      
end
