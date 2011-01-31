class User < ActiveRecord::Base
  attr_accessor :password_confirmation
  
  has_many :tweets
    
  validates :name, :presence => true

  validates :password,
              :length => {:minimum => 6, :maximum => 30 },
              :confirmation => true              

  validates :email,
              :presence => true,
              :uniqueness => true,
              :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password == password
      user
    else
      nil
    end
  end

end
