require File.join(Rails.root, 'config', 'environment')

namespace 'tweets' do  
  desc "Feed tweets table with some data"
  task :feed_tweets_table do
    homer = User.find_by_name("Homer")
    marge = User.find_by_name("Marge Simpson")
    bart = User.find_by_name("Bart Simpson")
    
    users = [homer, marge, bart]
    sentences = ["Just got up", "Having breakfast", "Going to work", 
                 "Lunch break!", "Time for bowling", "Exhausted and going to bed",
                 "Feeding the cat", "Yay! Itchy and Scratchy show!",
                 "I'd kill for a Duff Beer right now"]
    last_tweet_moment = Time.now
    50.times do
      tweeter = users[rand(3)]
      sentence = sentences[rand(9)]
      new_tweet = tweeter.tweets.create(:content => sentence, :created_at => last_tweet_moment - 5.minutes)
      last_tweet_moment = new_tweet.created_at
      sleep 2
    end
  end

  desc "Feed users table with some data"
  task :feed_users_table do
    {"Homer" => ["homer@simpsons.org", "nuclear"], "Marge Simpson" => ["marge@simpsons.org", "desperate"], "Bart Simpson" => ["bart@simpsons.org", "mosquis"]}.each do |name, data|
      user = User.find_or_initialize_by_name(name)
      user.email = data.first
      user.password = data.last
      user.password_confirmation = data.last
      user.save!
    end 
  end
end
