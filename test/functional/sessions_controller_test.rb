require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should log user in with correct info" do
    post :create, :email => "homer@simpsons.com", :password => "nuclear"
    assert_redirected_to root_path
    assert_not_nil(session[:user_id])
  end
  
  test "should not login user with incorrect info" do
    post :create, :email => "homer@simpsons.com", :password => "incorrect"
    assert_template "new"
    assert_equal "Invalid email or password", flash[:alert]
    assert_nil(session[:user_id])
  end
end
