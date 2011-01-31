require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "user logs in and ends up in timeline page" do
    get login_path
    
    post_via_redirect sessions_path, :email => users(:homer).email, 
                                     :password => users(:homer).password
    assert_equal "/", path
    assert_equal "Logged in!", flash[:notice]
    assert_not_nil(session[:user_id])
    
    assert_select 'div#user_nav', /Hello #{users(:homer).name}!/
  end
end
