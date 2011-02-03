class Tweet < ActiveRecord::Base
  belongs_to :user
  
  validates :user_id, :presence => true
  
  validates :content, 
            :presence => true,
            :length => {:maximum => 160}
            
  default_scope :order => 'created_at DESC'

  def self.from_users_followed_by(user)
    self.where(:user_id => user.following_ids+[user.id])
  end

end
