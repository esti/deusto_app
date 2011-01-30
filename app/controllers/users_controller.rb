class UsersController < ApplicationController

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to login_url, :notice => 'You have successfully signed up'
    else
      render :action => "new" 
    end
  end

end
