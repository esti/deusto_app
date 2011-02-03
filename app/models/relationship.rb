class Relationship < ActiveRecord::Base

  #
  # El valor de followed_id se modificará desde la interfaz web.
  #
  attr_accessible :followed_id

  #
  # Cada relación tiene:
  # 

  # un follower_id que correspone a un id de usuario
  belongs_to :follower, :class_name => "User"

  # y un followed_id que también corresponde a un id de usuario.
  belongs_to :followed, :class_name => "User"
end
