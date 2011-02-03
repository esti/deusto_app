require File.dirname(File.expand_path(__FILE__)) + "/../test_helper"

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

  test "logged in user should see users list" do
    login_as(:homer)
    get :index

    assert_response :success
    assert assigns(:users)
    assert !assigns(:users).empty? 
  end

  test "anonymous user should be redirected to login page when getting index" do
    get :index

    assert_redirected_to login_path
    assert_equal "You need to be logged in in order to see the users list", flash[:notice]
  end
end
