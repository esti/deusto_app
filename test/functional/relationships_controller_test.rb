require File.dirname(File.expand_path(__FILE__)) + "/../test_helper"

class RelationshipsControllerTest < ActionController::TestCase
  
  test "should create a relationship" do
    login_as(:homer)
   
    assert_difference("Relationship.count", 1) do
      post :create, :relationship => {:followed_id => users(:lisa).id}
    end

    assert_redirected_to user_path(users(:lisa))
  end

  test "should destry relationship" do
    login_as(:homer)
   
    assert_difference("Relationship.count", -1) do
      delete :destroy, :id => relationships(:homer_follows_marge).id
    end

    assert_redirected_to user_path(users(:marge))
  end

  test "should create a relationship using Ajax" do
    login_as(:homer)
   
    assert_difference("Relationship.count", 1) do
      xhr :post, :create, :relationship => {:followed_id => users(:lisa).id}
    end

    assert_response :success
  end



end
