require File.dirname(File.expand_path(__FILE__)) + "/../test_helper"

class TweetTest < ActiveSupport::TestCase
  setup do
    @default_attributes = {:user_id => users(:homer).id, :content => "Hello World!"}
  end
  
  test "should not save emtpy tweet" do
    tweet = Tweet.new(@default_attributes.merge(:content => nil))
    assert !tweet.valid?
    assert tweet.errors[:content].include?("can't be blank")
  end
  
  test "should not save too long tweet" do
    tweet = Tweet.new(@default_attributes.merge(:content => "Hello World!"*100))
    assert !tweet.valid?
    assert tweet.errors[:content].include?("is too long (maximum is 160 characters)")
  end

  test "should not save anonymous tweet" do
    tweet = Tweet.new(@default_attributes.merge(:user_id => nil))
    assert !tweet.valid?
    assert tweet.errors[:user_id].include?("can't be blank")
  end
  
  test "should list tweets in reversed time order by default" do
    tweets = Tweet.all
    assert tweets[0].created_at > tweets[1].created_at
  end
end
