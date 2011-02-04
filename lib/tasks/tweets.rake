require File.join(Rails.root, 'config', 'environment')

namespace 'tweets' do  
  desc "Feed tweets table with some data"
  task :feed_tweets_table do
    users = User.all
    
    sentences = ["Just got up", "Having breakfast", "Going to work", 
                 "Lunch break!", "Time for bowling", "Exhausted and going to bed",
                 "Feeding the cat", "Yay! Itchy and Scratchy show!",
                 "I'd kill for a Duff Beer right now"]
    last_tweet_moment = Time.now
    50.times do
      tweeter = users[rand(users.length)]
      sentence = sentences[rand(9)]
      new_tweet = tweeter.tweets.create(:content => sentence, :created_at => last_tweet_moment - 5.minutes)
      last_tweet_moment = new_tweet.created_at
      sleep 2
    end
  end
end