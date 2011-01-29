class User < ActiveRecord::Base
  validates :name, :presence => true

  validates :password,
              :length => {:minimum => 6, :maximum => 30 }

  validates :email,
              :presence => true,
              :uniqueness => true,
              :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
end
