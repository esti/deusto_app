class RelationshipsController < ApplicationController
  # Sólo los usuarios conectados pueden seguir o dejar de seguir a otro usuario.
  before_filter :login_required

  # Crear una relación seguidor-seguido: follow
  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)

    UserMailer.following_email(current_user, @user).deliver
    
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  # Eliminar una relación seguidor-seguido: unfollow
  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)

    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
