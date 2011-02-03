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
  
  #
  # Personas que el usuario sigue: following.
  #
  has_many :relationships, :foreign_key => "follower_id",
                           :dependent => :destroy
  has_many :following, :through => :relationships, :source => :followed


  #
  # Personas que siguen al usuario: followers.
  #
  has_many :reverse_relationships, :foreign_key => "followed_id",
                                   :class_name => "Relationship",
                                   :dependent => :destroy
  has_many :followers, :through => :reverse_relationships, :source => :follower

  #
  # Mensajes de los usuarios que el usuario sigue.
  #
  def feed
    Tweet.from_users_followed_by(self)
  end


  #
  # Devuelve true si el usuario sigue a followed.
  #
  def following?(followed)
    relationships.find_by_followed_id(followed)
  end

  #
  # Crea la relación entre el usuario y followed.
  # Si no se puede crear la relación, sale error.
  # 
  def follow!(followed)
    relationships.create!(:followed_id => followed.id)
  end

  #
  # Eliminar la relación entre el usuario y el followed.
  #
  def unfollow!(followed)
    relationships.find_by_followed_id(followed).destroy
  end


  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password == password
      user
    else
      nil
    end
  end

end
