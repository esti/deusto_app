require File.dirname(File.expand_path(__FILE__)) + "/../test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @default_attributes = {:name => "Lisa Simpson", 
                           :email => "lisa@simpsons.org", 
                           :password => "saxophone"}
  end
  
  test "should save record with all valid attributes" do
    user = User.new(@default_attributes)
    assert user.valid?
  end
  
  test "should not save record with empty name" do
    user = User.new(@default_attributes.merge(:name => nil))
    assert !user.valid?
    assert user.errors[:name].include?("can't be blank")
  end
  
  test "should not save record with empty email" do
    user = User.new(@default_attributes.merge(:email => nil))
    assert !user.valid?
    assert user.errors[:email].include?("can't be blank")
  end

  test "should not save record with too short password" do
    user = User.new(@default_attributes.merge(:password => "short"))
    assert !user.valid?
    assert user.errors[:password].include?("is too short (minimum is 6 characters)")
  end
  
  test "should not save record with invalid email" do
    user = User.new(@default_attributes.merge(:email => "invalid"))
    assert !user.valid?
    assert user.errors[:email].include?("is invalid")
  end
  
  test "should not save record with duplicated email address" do
    user1 = User.create!(@default_attributes)
    user2 = User.new(@default_attributes)
    assert !user2.valid?
    assert user2.errors[:email].include?("has already been taken")
  end

  test "should have relationships" do
    user = users(:homer)

    assert_equal [relationships(:homer_follows_marge)], user.relationships
  end

  test "should respond to following" do
    user = users(:homer)

    assert_equal [users(:marge)], user.following
  end

  test "should respond to following?" do
    user = users(:homer)
    
    assert user.following?(users(:marge))
  end

  test "should follow" do
    user = users(:homer)

    assert_difference("Relationship.count", 1) do
      user.follow!(users(:lisa))
    end

    assert user.following.include?(users(:lisa))
  end

  test "should unfollow" do
    user = users(:homer)

    assert_difference("Relationship.count", -1) do
      user.unfollow!(users(:marge))
    end

    assert user.following.empty? 
  end

  test "should get followers" do
    user = users(:homer)
   
    assert_equal [users(:marge)], user.followers 
  end
end
