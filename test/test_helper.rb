ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  
  def login_as(user)
    login(users(user).email, users(user).password)
  end
  
  def login(email, password)
    old_controller = @controller
    @controller = SessionsController.new
    @request.env['REMOTE_ADDR'] = "http://127.0.0.1"
    post :create, :email => email, :password => password
    assert_redirected_to @controller.send('root_path')
    assert_not_nil(session[:user_id])
    @controller = old_controller
  end
end
