class UserMailer < ActionMailer::Base
  default :from => "from@example.com"
  default_url_options[:host] = "localhost:3000"
  
  def following_email(follower, followee)
    @follower = follower
    @followee = followee
    mail(:to => followee.email, 
         :subject => "[DeustoTwitter] #{follower.name} is following you")
  end
end
