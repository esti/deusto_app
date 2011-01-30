require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => {:name => "Moo", :email => "moo@moos.com", 
                              :password => "duffbeer", :password_confirmation => "duffbeer"}
    end

    assert_redirected_to login_path
  end

end
